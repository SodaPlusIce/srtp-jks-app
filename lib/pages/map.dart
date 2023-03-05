import 'dart:convert';

import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtjs/config/appbar_settings.dart';
import 'package:via_logger/level.dart';
import 'package:via_logger/logger.dart';
import '../config/Order.dart';
import '../config/config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

/// 连接后端的接口信息
const YOUR_SERVER_IP = '127.0.0.1';
const YOUR_SERVER_PORT = '5000';
const String netip = 'http://$YOUR_SERVER_IP:$YOUR_SERVER_PORT';
const URL = 'ws://$YOUR_SERVER_IP:$YOUR_SERVER_PORT';

const double _kItemExtent = 32.0;

/// 站点名称
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

/// 终点站的坐标信息
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
  var title;
  bool backIcon = false; //待删除相关逻辑

  /// 控制地图下方控件的显示
  bool basic = true;
  bool reserve = false;
  bool gonow = false;
  bool isReserve = false;
  bool order = false;
  bool passNum = false;

  /// 预约选项中的时间选择
  DateTime dateTime = DateTime.now();
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

  /// 步骤x相关数据
  int _stepIndex = 0;
  final List<String> _stepName = <String>["步骤一", "步骤二", "步骤三", "步骤四"];

  /// 上车人数
  int _passNum = 1;

  /// 分配的车辆名
  String _allo_bus = "";

  /// 定义出polyline
  final Map<String, Polyline> _polylines = <String, Polyline>{};

  /// websocket定义
  late IO.Socket socket;

  /// 浮窗栏的文字样式
  var overlayTextStyle =
      const TextStyle(fontSize: 18, fontFamily: 'oppoSansRegular');
  var overlayTitleStyle =
      const TextStyle(fontSize: 16, fontFamily: 'oppoSansMedium');

  /// ////////////////////////////初始化程序代码///////////////////////////////////
  @override
  void initState() {
    super.initState();
    initSocket();
    // _showInitCarPos();
    _mapType = MapType.bus;

    /// 设置Android和iOS的apikey，
    AMapFlutterLocation.setApiKey(ConstConfig.androidKey, ConstConfig.iosKey);

    /// 设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyShow(true, true);
    // requestPermission();
    _addMarkerInit(); //添加各站点的marker
  }

  /// ////////////////////////////初始化socket的连接内容///////////////////////////
  initSocket() {
    socket = IO.io(URL, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }

  int colorsIndex = 0;
  // 初始添加的marker
  final Map<String, Marker> _initMarkerMap = <String, Marker>{};

  /// ///////////////////////////初始化的时候添加站点的maker信息/////////////////////
  void _addMarkerInit() async {
    // 添加站点marker
    for (int i = 0; i < stopLngLat.length; i++) {
      LatLng pos = LatLng(stopLngLat[i][1], stopLngLat[i][0]);
      // final ImageConfiguration imageConfiguration =
      //     createLocalImageConfiguration(context);
      Marker marker = Marker(
          // 修改当前路线的图标
          // icon: BitmapDescriptor.fromIconPath("assets/images/marker_icon.png"),
          position: pos,
          infoWindow: InfoWindow(title: _stationNames[i]));
      _initMarkers[marker.id] = marker;
    }
    // 添加车辆marker
    // 先获取现在在跑的车辆数
    int carNum = 5;
    for (int i = 1; i <= carNum; i++) {
      LatLng pos = LatLng(stopLngLat[i][1], stopLngLat[i][0]);
      Marker marker = Marker(
          position: pos,
          icon: BitmapDescriptor.fromIconPath("assets/images/bus$i$i$i.png"));
      _initMarkers[marker.id] = marker;
    }
  }

  //需要先设置一个空的map赋值给AMapWidget的markers，否则后续无法添加marker
  final Map<String, Marker> _initMarkers = <String, Marker>{};
  LatLng _currentLatLng = const LatLng(39.909187, 116.397451);

  /// 添加一个marker
  void _addMarker(LatLng pos, int i) {
    final Marker marker = Marker(
      position: pos,
      //使用默认hue的方式设置Marker的图标
      icon: BitmapDescriptor.fromIconPath("assets/images/bus$i$i$i.png"),
    );
    //调用setState触发AMapWidget的更新，从而完成marker的添加
    setState(() {
      _currentLatLng = pos;
      //将新的marker添加到map里
      _initMarkers[marker.id] = marker;
    });
  }

  /// 清除marker
  void _removeAll() {
    if (_initMarkers.isNotEmpty) {
      setState(() {
        _initMarkers.clear();
      });
    }
    // 添加站点marker
    for (int i = 0; i < stopLngLat.length; i++) {
      LatLng pos = LatLng(stopLngLat[i][1], stopLngLat[i][0]);
      // final ImageConfiguration imageConfiguration =
      // createLocalImageConfiguration(context);
      Marker marker = Marker(
          // 修改当前路线的图标
          icon: BitmapDescriptor.fromIconPath("assets/images/marker_icon.png"),
          position: pos,
          infoWindow: InfoWindow(title: _stationNames[i]));
      _initMarkers[marker.id] = marker;
    }
  }

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

  /// ///////////////////////////获取审图号///////////////////////////////////////
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
    // 定位销毁
    location?.destroy();
    // socket销毁
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  /// ///////////////////////////显示选择对话框////////////////////////////////////
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

  /// ///////////////////////////弹出"选择出行方式"旁的info按钮对应的对话框////////////
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

  /// ////////////////////////调用接口： test/////////////////////////////////////
  Future<void> addOrderInfo(Order order) async {
    /*  FormData formData = FormData.fromMap(
        {"stop_on": on, "stop_off": off,"passengers":pass});*/

    String url = "$netip/addOrder";
    BaseOptions options = BaseOptions(
      responseType: ResponseType.plain,
    );
    Dio dio = Dio(options);
    FormData formData = FormData.fromMap({
      "stop_on": order.getCarLocation,
      "stop_off": order.destination,
      "passengers": order.passengerNum,
      "expected_on": order.expected_on
    });
    var res = await dio.post(url, data: formData);
    // Response res  = await dio.post(url,data:jsonEncode(order));
    // var res = await http.post(Uri.parse(url),body: );
    if (res.statusCode == 200) {
      var data = res.data;
      var index = data.indexOf('S');
      data = 'S${data[index + 1]}';
      setState(() {
        _allo_bus = data;
      });
      // 起点到终点显示绿线
      _add(_stationNames.indexWhere((v) => v == order.getCarLocation),
          _stationNames.indexWhere((v) => v == order.destination)); //添加polyline
    } else {
      print("Failed to get data.~~~");
      // 做出提示，网络连接有问题
    }
  }

  /// ///////////////////////////添加地图中的画线//////////////////////////////////
  List<LatLng> _createPoints(start, end) {
    final List<LatLng> points = <LatLng>[];
    // for (int i = 0; i < stopLngLat.length; i++) {
    points.add(LatLng(stopLngLat[end][1], stopLngLat[end][0]));
    points.add(LatLng(stopLngLat[start][1], stopLngLat[start][0]));
    // }
    return points;
  }

  void _add(start, end) {
    final Polyline polyline = Polyline(
      // color:Colors.green,
      width: 20,
      customTexture:
          BitmapDescriptor.fromIconPath('assets/images/texture_green.png'),
      joinType: JoinType.round,
      points: _createPoints(start, end),
    );
    setState(() {
      _polylines[polyline.id] = polyline;
    });
  }

  /// ///////////////////////////利用websocket进行车辆的实时数据传输/////////////////
/*
* 初始化的时候，将车辆的数据显示在屏幕上
*
* */
  _initCar() {
    int count = 0;
    Timer.periodic(const Duration(microseconds: 10), (timer) {
      count++;
      socket.emit("app_pos");
      socket.on("app_pos", (data) {
        // print(data);
        _removeAll();
        // print("清除成功");
        for (int i = 0; i < data.length; i++) {
          setState(() {
            LatLng pos = LatLng(data[i][1], data[i][0]);
            _addMarker(pos, i + 1);
          });
          // print("添加成功");
        }
      });
      if (count == 5) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _initCar();
    Logger.minLevel = Level.WARNING;
    final AMapWidget map = AMapWidget(
      polylines: Set<Polyline>.of(_polylines.values),
      // 隐私政策包含高德 必须填写
      privacyStatement: ConstConfig.amapPrivacyStatement,
      apiKey: ConstConfig.amapApiKeys,
      // 初始化地图中心
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
      markers: Set<Marker>.of(_initMarkers.values),
      // compassEnabled: true,
      trafficEnabled: true,
      // 地图创建成功时返回AMapController
      onMapCreated: (AMapController controller) {
        // mapController = controller;
        setState(() {
          mapController = controller;
          getApprovalNumber();
        });
      },
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: UnionAppBar(
          title: "预约响应", colors: const Color.fromARGB(255, 247, 251, 255)),
      body: GFFloatingWidget(
        body: map,
        //背景模糊的颜色
        blurnessColor: Colors.blue,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Opacity(
            opacity: 0.818,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                color: const Color.fromARGB(250, 250, 252, 254),
                shadowColor: const Color.fromARGB(250, 231, 241, 251),
                elevation: 20,
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
                                  // title = "智慧公交——预约响应";
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
                          height: 180,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '选择出行方式',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontFamily: "oppoSansBold",
                                          ),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.all(2)),
                                        IconButton(
                                            padding: const EdgeInsets.all(0),
                                            icon:
                                                const Icon(Icons.info_outlined),
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
                                child: Text(
                                  "预约出行",
                                  style: overlayTextStyle,
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
                                  child: Text(
                                    '现在出发',
                                    style: overlayTextStyle,
                                  )),
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
                                        onDateTimeChanged:
                                            (DateTime newDateTime) {
                                          setState(() {
                                            dateTime = newDateTime;
                                            reserveTime =
                                                '${dateTime.year}-${dateTime.month}-${dateTime.day + 1}'
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
                                          onSelectedItemChanged:
                                              (int selectedItem) {
                                            setState(() {
                                              _selectedOnStation = selectedItem;
                                              _selectedOnStationName =
                                                  _stationNames[
                                                      _selectedOnStation];
                                            });
                                          },
                                          children: List<Widget>.generate(
                                              _stationNames.length,
                                              (int index) {
                                            return Center(
                                              child: Text(
                                                _stationNames[index],
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                      child: Text(_selectedOnStationName,
                                          style: overlayTextStyle),
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
                                          onSelectedItemChanged:
                                              (int selectedItem) {
                                            setState(() {
                                              _selectedOffStation =
                                                  selectedItem;
                                              _selectedOffStationName =
                                                  _stationNames[
                                                      _selectedOffStation];
                                            });
                                          },
                                          children: List<Widget>.generate(
                                              _stationNames.length,
                                              (int index) {
                                            return Center(
                                              child: Text(
                                                _stationNames[index],
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                      child: Text(_selectedOffStationName,
                                          style: overlayTextStyle),
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
                                        onSelectedItemChanged:
                                            (int selectedItem) {
                                          setState(() {
                                            _selectedOnStationNow =
                                                selectedItem;
                                            _selectedOnStationNameNow =
                                                _stationNames[
                                                    _selectedOnStationNow];
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
                                        style: overlayTextStyle),
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
                                        onSelectedItemChanged:
                                            (int selectedItem) {
                                          setState(() {
                                            _selectedOffStationNow =
                                                selectedItem;
                                            _selectedOffStationNameNow =
                                                _stationNames[
                                                    _selectedOffStationNow];
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
                            Text("请选择乘客数：$_passNum人", style: overlayTitleStyle),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                        style: overlayTitleStyle),
                                    Text(
                                        "上车时间：${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}",
                                        style: overlayTitleStyle),
                                    Text(
                                        "上车点：${isReserve ? _selectedOnStationName : _selectedOnStationNameNow}",
                                        style: overlayTitleStyle),
                                    Text(
                                        "目的地：${isReserve ? _selectedOffStationName : _selectedOffStationNameNow}",
                                        style: overlayTitleStyle),
                                    Text("乘客数：$_passNum",
                                        style: overlayTitleStyle),
                                    Text("分配车辆：$_allo_bus",
                                        style: overlayTitleStyle),
/*
                                    const Padding(padding: EdgeInsets.all(10)),
*/
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              String on = isReserve
                                                  ? _selectedOnStationName
                                                  : _selectedOnStationNameNow;
                                              String off = isReserve
                                                  ? _selectedOffStationName
                                                  : _selectedOffStationNameNow;
                                              Order order = Order(on, off,
                                                  _passNum, reserveTime);
                                              addOrderInfo(order);
                                            },
                                            style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)))),
                                            child: const Text(
                                              "提交订单",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "oppoSansBold"),
                                            ),
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
                )),
          ),
        ),
      ),

      // 地图以下的文字和按钮组件
    );
  }

  /// 获取周边数据
  // Future<void> _getPoisData() async {
  //   var response = await Dio().get(
  //       'https://restapi.amap.com/v3/place/around?key=${ConstConfig.webKey}&location=$markerLatitude,$markerLongitude&keywords=&types=&radius=1000&offset=20&page=1&extensions=base');
  //   setState(() {
  //     poisData = response.data['pois'];
  //   });
  // }
}
