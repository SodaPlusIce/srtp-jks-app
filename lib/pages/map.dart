import 'dart:io';

import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../config/config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

const double _kItemExtent = 32.0;
const List<String> _stationNames = <String>[
  "换乘中心", //0
  "镇西村", //1
  "石淙村", //2
  "姚家坝村", //3
  "银子桥村", //4
  "羊河坝村", //5
  "花园湾村", //6
  "南坝村", //7
];
const List<List> stopLngLat = <List>[
  [120.265966, 30.721857], //0
  [120.247437, 30.724458], //1
  [120.268674, 30.731679], //2
  [120.289797, 30.725002], //3
  [120.276203, 30.705706], //4
  [120.262589, 30.703787], //5
  [120.252128, 30.707662], //6
  [120.25047, 30.697339], //7
];

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  ///地图通信中心
  AMapController? mapController;

  /// 定位插件
  AMapFlutterLocation? location;

  /// 权限状态
  PermissionStatus? permissionStatus;

  /// 相机位置
  CameraPosition currentLocation = const CameraPosition(
    target: LatLng(30.716747, 120.265966),
    zoom: 13.8,
  );

  /// 地图类型
  late MapType _mapType;

  /// 周边数据
  List poisData = [];

  var markerLatitude;
  var markerLongitude;

  double? meLatitude;
  double? meLongitude;

  /// AppBar的title
  var title = "智慧公交——定位";
  bool backIcon = false; //待删除相关逻辑

  /// 控制地图下方控件的显示
  bool basic = true;
  bool reserve = false;
  bool gonow = false;
  bool isReserve = false;
  bool order = false;
  bool passNum = false;

  /// 预约选项中的时间选择
  DateTime dateTime = DateTime(2023, 2, 4, 14, 16);
  String reserveTime = "选择 时间段";

  /// 预约 上下车点index,name
  int _selectedOnStation = 0;
  int _selectedOffStation = 0;
  String _selectedOnStationName = "选择 上车点";
  String _selectedOffStationName = "选择 目的地";

  /// 响应 上下车点index,name
  int _selectedOnStationNow = 0;
  int _selectedOffStationNow = 0;
  String _selectedOnStationNameNow = "选择 上车点";
  String _selectedOffStationNameNow = "选择 目的地";

  /// step中的left和right的IconButton的显示与否
  // bool _stepLeftButton = false;
  // bool _stepRightButton = true;
  int _stepIndex = 0;
  final List<String> _stepName = <String>["步骤一", "步骤二", "步骤三", "步骤四"];

  /// 上车人数
  int _passNum = 1;

  @override
  void initState() {
    super.initState();
    _mapType = MapType.normal;

    /// 设置Android和iOS的apikey，
    AMapFlutterLocation.setApiKey(ConstConfig.androidKey, ConstConfig.iosKey);

    /// 设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyShow(true, true);
    // requestPermission();
  }

  // Future<void> requestPermission() async {
  //   final status = await Permission.location.request();
  //   permissionStatus = status;
  //   switch (status) {
  //     case PermissionStatus.denied:
  //       print("拒绝");
  //       break;
  //     case PermissionStatus.granted:
  //       requestLocation();
  //       break;
  //     case PermissionStatus.limited:
  //       print("限制");
  //       break;
  //     default:
  //       print("其他状态");
  //       requestLocation();
  //       break;
  //   }
  // }

  /// 请求位置
  // void requestLocation() {
  //   location = AMapFlutterLocation()
  //     ..setLocationOption(AMapLocationOption())
  //     ..onLocationChanged().listen((event) {
  //       print(event);
  //       double? latitude = double.tryParse(event['latitude'].toString());
  //       double? longitude = double.tryParse(event['longitude'].toString());
  //       markerLatitude = latitude.toString();
  //       markerLongitude = longitude.toString();
  //       meLatitude = latitude;
  //       meLongitude = longitude;
  //       if (latitude != null && longitude != null) {
  //         setState(() {
  //           currentLocation = CameraPosition(
  //             target: LatLng(latitude, longitude),
  //             zoom: 10,
  //           );
  //         });
  //       }
  //     })
  //     ..startLocation();
  // }

  // void _onMapPoiTouched(AMapPoi poi) async {
  //   if (null == poi) {
  //     return;
  //   }
  //   print('_onMapPoiTouched===> ${poi.toJson()}');
  //   var xx = poi.toJson();
  //   print(xx['latLng']);
  //   markerLatitude = xx['latLng'][1];
  //   markerLongitude = xx['latLng'][0];
  //   print(markerLatitude);
  //   print(markerLatitude);
  //   setState(() {
  //     _addMarker(poi.latLng!);
  //   });
  //   _getPoisData();
  // }

  // 初始添加的marker
  final Map<String, Marker> _initMarkerMap = <String, Marker>{};
  void _addMarker() async {
    // 添加站点marker
    for (int i = 0; i < stopLngLat.length; i++) {
      LatLng pos = LatLng(stopLngLat[i][1], stopLngLat[i][0]);
      Marker marker = Marker(
          position: pos, infoWindow: InfoWindow(title: _stationNames[i]));
      _initMarkerMap[marker.id] = marker;
    }
    // 添加车辆marker
    // 先获取现在在跑的车辆数
    int carNum = 1;
    LatLng pos = LatLng(stopLngLat[0][1], stopLngLat[0][0]);
    for (int i = 1; i <= carNum; i++) {
      Marker marker = Marker(
          position: pos,
          icon: BitmapDescriptor.fromIconPath("assets/images/bus$i$i$i.png"));
      _initMarkerMap[marker.id] = marker;
    }
    // BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(),
    //   "assets/images/bus111.png",
    // );
    // Marker marker = Marker(position: pos, icon: markerbitmap);
    // _initMarkerMap[marker.id] = marker;
  }

  /// 清除marker
  // void _removeAll() {
  //   if (_markers.isNotEmpty) {
  //     setState(() {
  //       _markers.clear();
  //     });
  //   }
  // }

  /// 改变中心点
  // void _changeCameraPosition(LatLng markPostion, {double zoom = 13}) {
  //   mapController?.moveCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //           //中心点
  //           target: markPostion,
  //           //缩放级别
  //           zoom: zoom,
  //           //俯仰角0°~45°（垂直与地图时为0）
  //           tilt: 30,
  //           //偏航角 0~360° (正北方为0)
  //           bearing: 0),
  //     ),
  //     animated: true,
  //   );
  // }

  /// 获取审图号
  void getApprovalNumber() async {
    //普通地图审图号
    String? mapContentApprovalNumber =
        await mapController?.getMapContentApprovalNumber();
    //卫星地图审图号
    String? satelliteImageApprovalNumber =
        await mapController?.getSatelliteImageApprovalNumber();
  }

  @override
  void dispose() {
    location?.destroy();
    super.dispose();
  }

  /// 显示选择对话框
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system
              // navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  // 弹出"选择出行方式"旁的info按钮对应的对话框
  Future<bool?> showDeleteConfirmDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("提示"),
          content: const Text("出行方式包括两种：预约出行 和 现在出发。\n"
              "预约出行 指在出行日期前一天通过App进行预约，在预约的上车点及时间点附近乘车。\n"
              "现在出发 指您当前在站点，通过电子站台或App的操作可以即刻增添订单，完成出行。"),
          actions: <Widget>[
            TextButton(
              child: const Text("我知道了"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _addMarker(); //添加各站点的marker
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // leading: backIcon
        //     ? IconButton(
        //         onPressed: () {
        //           basic = true;
        //           reserve = false;
        //           gonow = false;
        //           backIcon = false;
        //           title = "智能公交——预约响应";
        //         },
        //         icon: const Icon(Icons.arrow_back_outlined))
        //     : null,
        title: const Text("智慧公交--预约"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin:const EdgeInsets.all(5),
                  color: Colors.greenAccent,
                  shadowColor: Colors.white54,
                  elevation:20 ,
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Visibility(
                            visible: _stepIndex != 0,
                            maintainSize: true,
                            maintainState: true,
                            maintainAnimation: true,
                            child: IconButton(
                              icon: const Icon(Icons.west_outlined),
                              onPressed: () {
                                setState(() {
                                  _stepIndex--;
                                  if (_stepIndex == 0) {
                                    basic = true;
                                    title = "智能公交——预约";
                                    reserve = false;
                                    gonow = false;
                                    order = false;
                                  } else if (_stepIndex == 1) {
                                    reserve = isReserve;
                                    gonow = !isReserve;
                                    passNum = false;
                                  } else if (_stepIndex == 2) {
                                    passNum = true;
                                    order = false;
                                  }
                                });
                              },
                            )),
                        const Padding(padding: EdgeInsets.only(left: 95)),
                        Text(
                          _stepName[_stepIndex],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 95)),
                        Visibility(
                            visible: _stepIndex != 3,
                            maintainSize: true,
                            maintainState: true,
                            maintainAnimation: true,
                            child: IconButton(
                              icon: const Icon(Icons.east_outlined),
                              onPressed: () {
                                setState(() {
                                  _stepIndex++;
                                  if (_stepIndex == 1) {
                                    basic = false;
                                    if (!isReserve) {
                                      gonow = true; //不选择出行方式直接点击下一步icon默认是即刻出发
                                      title = "现在出发";
                                    } else {
                                      reserve = true;
                                      title = "预约出行";
                                    }
                                  } else if (_stepIndex == 2) {
                                    basic = false;
                                    gonow = false;
                                    reserve = false;
                                    passNum = true;
                                  } else if (_stepIndex == 3) {
                                    passNum = false;
                                    order = true;
                                  }
                                });
                              },
                            )),
                      ]),
                      // 步骤一：选择出行方式
                      Visibility(
                          visible: basic,
                          child: Container(
                            height: 200,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            '选择出行方式',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Padding(padding: EdgeInsets.all(2)),
                                          IconButton(
                                              padding: const EdgeInsets.all(0),
                                              icon: const Icon(Icons.info_outlined),
                                              onPressed: () {
                                                showDeleteConfirmDialog();
                                              })
                                        ])),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(180, 50)),
                                  onPressed: () {
                                    setState(() {
                                      basic = false;
                                      reserve = true;
                                      gonow = false;
                                      _stepIndex++;
                                      title = "预约出行";
                                      isReserve = true;
                                    });
                                  },
                                  child: const Text(
                                    "预约出行",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(5)),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(180, 50)),
                                  onPressed: () {
                                    setState(() {
                                      basic = false;
                                      gonow = true;
                                      reserve = false;
                                      _stepIndex++;
                                      title = "现在出发";
                                      isReserve = false;
                                    });
                                  },
                                  child: const Text('现在出发', style: TextStyle(fontSize: 18)),
                                ),
                              ],
                            ),
                          )),
                      // 步骤二：预约出行
                      Visibility(
                          visible: reserve,
                          child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(padding: EdgeInsets.all(7)),
                                  const Text(
                                    '注意：仅支持提前一天预约，预约时间前后五分钟到车',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  CupertinoButton(
                                    onPressed: () => {},
                                    padding: const EdgeInsets.all(0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(180, 50)),
                                      onPressed: () => _showDialog(
                                        CupertinoDatePicker(
                                          initialDateTime: dateTime,
                                          mode: CupertinoDatePickerMode.time,
                                          use24hFormat: true,
                                          // This is called when the user changes the dateTime.
                                          onDateTimeChanged: (DateTime newDateTime) {
                                            setState(() {
                                              dateTime = newDateTime;
                                              reserveTime =
                                              '${dateTime.year}-${dateTime.month}-${dateTime.day}'
                                                  ' ${dateTime.hour}:${dateTime.minute}';
                                            });
                                          },
                                        ),
                                      ),
                                      child: Text(
                                        reserveTime,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  CupertinoButton(
                                      padding: const EdgeInsets.all(0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(180, 50)),
                                        onPressed: () => _showDialog(
                                          CupertinoPicker(
                                            magnification: 1.22,
                                            squeeze: 1.2,
                                            useMagnifier: true,
                                            itemExtent: _kItemExtent,
                                            // This is called when selected item is changed.
                                            onSelectedItemChanged: (int selectedItem) {
                                              setState(() {
                                                _selectedOnStation = selectedItem;
                                                _selectedOnStationName =
                                                _stationNames[_selectedOnStation];
                                              });
                                            },
                                            children: List<Widget>.generate(
                                                _stationNames.length, (int index) {
                                              return Center(
                                                child: Text(
                                                  _stationNames[index],
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                        child: Text(_selectedOnStationName,
                                            style: const TextStyle(fontSize: 18)),
                                      ),
                                      onPressed: () {}),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  CupertinoButton(
                                      padding: const EdgeInsets.all(0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(180, 50)),
                                        onPressed: () => _showDialog(
                                          CupertinoPicker(
                                            magnification: 1.22,
                                            squeeze: 1.2,
                                            useMagnifier: true,
                                            itemExtent: _kItemExtent,
                                            // This is called when selected item is changed.
                                            onSelectedItemChanged: (int selectedItem) {
                                              setState(() {
                                                _selectedOffStation = selectedItem;
                                                _selectedOffStationName =
                                                _stationNames[_selectedOffStation];
                                              });
                                            },
                                            children: List<Widget>.generate(
                                                _stationNames.length, (int index) {
                                              return Center(
                                                child: Text(
                                                  _stationNames[index],
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                        child: Text(_selectedOffStationName,
                                            style: const TextStyle(fontSize: 18)),
                                      ),
                                      onPressed: () {}),
                                ],
                              ))),
                      // 步骤二：现在出发
                      Visibility(
                          visible: gonow,
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(padding: EdgeInsets.all(12)),
                                CupertinoButton(
                                    padding: const EdgeInsets.all(0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(180, 50)),
                                      onPressed: () => _showDialog(
                                        CupertinoPicker(
                                          magnification: 1.22,
                                          squeeze: 1.2,
                                          useMagnifier: true,
                                          itemExtent: _kItemExtent,
                                          // This is called when selected item is changed.
                                          onSelectedItemChanged: (int selectedItem) {
                                            setState(() {
                                              _selectedOnStationNow = selectedItem;
                                              _selectedOnStationNameNow =
                                              _stationNames[_selectedOnStationNow];
                                            });
                                          },
                                          children: List<Widget>.generate(
                                              _stationNames.length, (int index) {
                                            return Center(
                                              child: Text(
                                                _stationNames[index],
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                      child: Text(_selectedOnStationNameNow,
                                          style: const TextStyle(fontSize: 18)),
                                    ),
                                    onPressed: () {}),
                                const Padding(padding: EdgeInsets.all(5)),
                                CupertinoButton(
                                    padding: const EdgeInsets.all(0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(180, 50)),
                                      onPressed: () => _showDialog(
                                        CupertinoPicker(
                                          magnification: 1.22,
                                          squeeze: 1.2,
                                          useMagnifier: true,
                                          itemExtent: _kItemExtent,
                                          // This is called when selected item is changed.
                                          onSelectedItemChanged: (int selectedItem) {
                                            setState(() {
                                              _selectedOffStationNow = selectedItem;
                                              _selectedOffStationNameNow =
                                              _stationNames[_selectedOffStationNow];
                                            });
                                          },
                                          children: List<Widget>.generate(
                                              _stationNames.length, (int index) {
                                            return Center(
                                              child: Text(
                                                _stationNames[index],
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                      child: Text(_selectedOffStationNameNow,
                                          style: const TextStyle(fontSize: 18)),
                                    ),
                                    onPressed: () {}),
                              ],
                            ),
                          )),
                      // 步骤三：填写人数
                      Visibility(
                          visible: passNum,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("请选择乘客数：$_passNum人", style: TextStyle(fontSize: 16)),
                              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _passNum = 1;
                                      });
                                    },
                                    child: Text("1人")),
                                const Padding(padding: EdgeInsets.all(5)),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _passNum = 2;
                                      });
                                    },
                                    child: Text("2人")),
                                const Padding(padding: EdgeInsets.all(5)),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _passNum = 3;
                                      });
                                    },
                                    child: Text("3人")),
                              ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _passNum = 4;
                                        });
                                      },
                                      child: Text("4人")),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _passNum = 5;
                                        });
                                      },
                                      child: Text("5人")),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _passNum = 6;
                                        });
                                      },
                                      child: Text("6人")),
                                ],
                              )
                            ],
                          )),
                      // 步骤四：提交订单
                      Visibility(
                          visible: order,
                          child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                textBaseline: TextBaseline.ideographic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Column(

                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("订单类型：${isReserve ? "预约出行" : "现在出发"}",
                                          style: const TextStyle(fontSize: 16)),
                                      Visibility(
                                          visible: isReserve,
                                          child: Text(
                                              "上车时间：${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}",
                                              style: const TextStyle(fontSize: 16))),
                                      Text(
                                          "上车点：${isReserve ? _selectedOnStationName : _selectedOnStationNameNow}",
                                          style: const TextStyle(fontSize: 16)),
                                      Text(
                                          "目的地：${isReserve ? _selectedOffStationName : _selectedOffStationNameNow}",
                                          style: const TextStyle(fontSize: 16)),
                                      Text("乘客数：$_passNum",
                                          style: const TextStyle(fontSize: 16)),
                                      const Padding(padding: EdgeInsets.all(10)),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(20)))),
                                              child: const Text("提交订单"),
                                            ),
                                          ]),
                                    ],
                                  )

                                ],
                              ))),
                      const SizedBox(
                        height: 16,
                        // width: 2000,
                      )
                    ],
                  )
              ),
              Expanded(flex:1,
                  child: SizedBox(
                // height: 340,
                child: AMapWidget(
                  // 隐私政策包含高德 必须填写
                  privacyStatement: ConstConfig.amapPrivacyStatement,
                  apiKey: ConstConfig.amapApiKeys,
                  // 初始化地图中心店
                  initialCameraPosition: currentLocation,
                  //定位小蓝点
                  myLocationStyleOptions: MyLocationStyleOptions(
                    true,
                  ),
                  // 普通地图normal,卫星地图satellite,夜间视图night,导航视图 navi,公交视图bus,
                  mapType: _mapType,
                  // 缩放级别范围
                  minMaxZoomPreference: const MinMaxZoomPreference(3, 20),
                  // onPoiTouched: _onMapPoiTouched,
                  markers: Set<Marker>.of(_initMarkerMap.values),
                  compassEnabled: true,
                  trafficEnabled: true,
                  // 地图创建成功时返回AMapController
                  onMapCreated: (AMapController controller) {
                    // mapController = controller;
                    setState(() {
                      mapController = controller;
                      getApprovalNumber();
                    });
                  },
                ),
              ))

            ],
          ),

          // 地图以下的文字和按钮组件


          // const Padding(padding: EdgeInsets.all(10)),

      /*floatingActionButton: SpeedDial(
        // marginRight: 25, //右边距
        // marginBottom: 50, //下边距
        animatedIcon: AnimatedIcons.menu_close, //带动画的按钮
        animatedIconTheme: const IconThemeData(size: 22.0),
        // visible: isShow, //是否显示按钮
        closeManually: false, //是否在点击子按钮后关闭展开项
        curve: Curves.bounceIn, //展开动画曲线
        overlayColor: Colors.black, //遮罩层颜色
        overlayOpacity: 0.5, //遮罩层透明度
        onOpen: () => print('OPENING DIAL'), //展开回调
        onClose: () => print('DIAL CLOSED'), //关闭回调
        tooltip: 'Speed Dial', //长按提示文字
        heroTag: 'speed-dial-hero-tag', //hero标记
        backgroundColor: Colors.blue, //按钮背景色
        foregroundColor: Colors.white, //按钮前景色/文字色
        elevation: 8.0, //阴影
        shape: const CircleBorder(), //shape修饰
        children: [
          //子按钮
          SpeedDialChild(
              label: '普通地图',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                // onButtonClick(1);
                setState(() {
                  _mapType = MapType.normal;
                });
              }),
          SpeedDialChild(
            label: '卫星地图',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              setState(() {
                _mapType = MapType.satellite;
              });
            },
          ),
          SpeedDialChild(
            label: '导航地图',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              setState(() {
                _mapType = MapType.navi;
              });
            },
          ),
          SpeedDialChild(
            label: '公交地图',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              setState(() {
                _mapType = MapType.bus;
              });
            },
          ),
          SpeedDialChild(
            label: '黑夜模式',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              setState(() {
                _mapType = MapType.night;
              });
            },
          ),
        ],
      ),*/
    );
  }

  // Widget _buildPoisList() {
  //   return Column(
  //     children: poisData.map((value) {
  //       return ListTile(
  //         title: Text(value['name']),
  //         subtitle: Text(
  //             '${value['pname']}${value['cityname']}${value['adname']}${value['address']}'),
  //         onTap: () async {
  //           List locationData = value['location'].split(',');
  //           double l1 = double.parse(locationData[1]);
  //           double l2 = double.parse(locationData[0]);
  //           markerLatitude = l2;
  //           markerLongitude = l1;
  //           // _getPoisData();
  //           // _addMarker(LatLng(l1, l2));
  //           // _changeCameraPosition(LatLng(l1, l2));
  //         },
  //         onLongPress: () {
  //           showCupertinoDialog(
  //               context: context,
  //               builder: (context) {
  //                 return CupertinoAlertDialog(
  //                   title: const Text('提示'),
  //                   content: const Text('是否进入高德地图导航'),
  //                   actions: <Widget>[
  //                     CupertinoDialogAction(
  //                       child: const Text('取消'),
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                     ),
  //                     CupertinoDialogAction(
  //                       child: Text('确认'),
  //                       onPressed: () async {
  //                         String title = value['name'];
  //                         var locationData = value['location'].split(',');
  //                         double l1 = double.parse(locationData[1]);
  //                         double l2 = double.parse(locationData[0]);

  //                         Uri uri = Uri.parse(
  //                             '${Platform.isAndroid ? 'android' : 'ios'}amap://path?sourceApplication=applicationName&sid=&slat=$meLatitude&slon=$meLongitude&sname=&did=&dlat=$l1&dlon=$l2&dname=$title&dev=0&t=0');

  //                         try {
  //                           if (await canLaunchUrl(uri)) {
  //                             await launchUrl(uri);
  //                           } else {
  //                             print('无法调起高德地图');
  //                           }
  //                         } catch (e) {
  //                           print('无法调起高德地图');
  //                         }
  //                         Navigator.pop(context);
  //                       },
  //                     ),
  //                   ],
  //                 );
  //               });
  //         },
  //       );
  //     }).toList(),
  //   );
  // }

  /// 获取周边数据
  // Future<void> _getPoisData() async {
  //   var response = await Dio().get(
  //       'https://restapi.amap.com/v3/place/around?key=${ConstConfig.webKey}&location=$markerLatitude,$markerLongitude&keywords=&types=&radius=1000&offset=20&page=1&extensions=base');
  //   setState(() {
  //     poisData = response.data['pois'];
  //   });
  // }
}
