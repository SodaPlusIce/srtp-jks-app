import 'dart:convert' as convert;

import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:jtjs/config/appbar_settings.dart';
import 'package:via_logger/level.dart';
import 'package:via_logger/logger.dart';
import '../config/Order.dart';
import '../config/config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

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

class CurrentOrderPage extends StatefulWidget {
  const CurrentOrderPage({Key? key}) : super(key: key);

  @override
  State<CurrentOrderPage> createState() => _CurrentOrderPageState();
}

class _CurrentOrderPageState extends State<CurrentOrderPage> {
  ///地图通信中心
  AMapController? mapController;

  /// 定位插件
  AMapFlutterLocation? location;

  /// 权限状态
  PermissionStatus? permissionStatus;

  /// 相机位置
  CameraPosition currentLocation = const CameraPosition(
    target: LatLng(30.716747, 120.265966),
    // 放缩层级
    zoom: 13.6,
  );

  /// 地图类型
  late MapType _mapType;

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
  bool carOrder = false;

  /// 预约选项中的时间选择
  DateTime dateTime = DateTime.now();
  String reserveTime = "选择 时间段";





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
    // 普通地图normal,卫星地图satellite,夜间视图night,导航视图 navi,公交视图bus,
    _mapType = MapType.navi;

    /// 设置Android和iOS的apikey，
    AMapFlutterLocation.setApiKey(ConstConfig.androidKey, ConstConfig.iosKey);

    /// 设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyShow(true, true);
    _createInitPointsRoutes();
    // requestPermission();
    _addMarkerInit(); //添加各站点的marker
    // _initCar();
    // _getDriverData();
  }

  /// ////////////////////////////初始化socket的连接内容///////////////////////////
  initSocket() {
    socket = IO.io(ConstConfig.URL, <String, dynamic>{
      'autoConnect': true,
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
          icon: BitmapDescriptor.fromIconPath("assets/images/start.png"),
          position: pos,
          infoWindow: InfoWindow(title: _stationNames[i]));
      _initMarkers[marker.id] = marker;
    }
  }

  /// ///////////////////////////获取审图号///////////////////////////////////////
  void getApprovalNumber() async {
    //普通地图审图号
    //卫星地图审图号
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

  /// ////////////////////////调用接口： addOrder/////////////////////////////////
  Future<void> addOrderInfo(Order order) async {
    /*  FormData formData = FormData.fromMap(
        {"stop_on": on, "stop_off": off,"passengers":pass});*/

    String url = "${ConstConfig.netip}/addOrder";
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

  /// ///////////////////////////根据每次的路线信息去构建整体的路线图//////////////////////////////////
  List<LatLng> pointsOfInitRoute = <LatLng>[];
  Future<List<LatLng>> _createInitPointsRoutes() async {
    String url = "${ConstConfig.netip}/routeInitial";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      //由于后端传回来的数据为utf-8编码，因此需要对其进行转换数据格式
      List arrs = convert.jsonDecode(res.body);
      print("myTag");
      print(arrs);
      for (var i = 0; i < arrs.length; i++) {
        for (var j = 0; j < arrs[i].length; j++) {
          pointsOfInitRoute.add(LatLng(arrs[i][j][1], arrs[i][j][0]));
        }
      }
      final Polyline polyline = Polyline(
        // color:Colors.green,
        width: 20,
        customTexture:
            BitmapDescriptor.fromIconPath('assets/images/texture_blue.png'),
        joinType: JoinType.round,
        points: pointsOfInitRoute,
      );
      setState(() {
        _polylines[polyline.id] = polyline;
      });
      // 对页面进行刷新
    } else {
      print("Failed to get data.~~~");
      // 做出提示，网络连接有问题
    }
    return pointsOfInitRoute;
  }

  /// ///////////////////////////利用websocket进行车辆的实时数据传输/////////////////
/*
* 初始化的时候，将车辆的数据显示在屏幕上
*
**/
  _initCar() {
    socket.emit("app_pos_driver");
    socket.on("app_pos_driver", (data) {
      print("666666获取到车辆路线数据");
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
  }

  /// //利用socket进行司机页面 下一站，车上人数，下一站等待人数 的实时传输//
  var nextStop;
  var nextStopWaitingNum;
  var passOnBus;
  _getDriverData() {
    socket.emit("driver_info");
    socket.on("driver_info", (data) {
      setState(() {
        nextStop = data[0];
        passOnBus = data[1];
        nextStopWaitingNum = data[2];
      });

      // print("666666$data");
    });
  }

  @override
  Widget build(BuildContext context) {
    _initCar();
    _getDriverData();

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
            opacity: 0.9,
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
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              color: Colors.white70,
                              shadowColor:
                                  const Color.fromARGB(250, 231, 241, 251),
                              elevation: 20,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              0,
                                              0,
                                              0)),
                                      IconButton(
                                          padding: const EdgeInsets.all(0),
                                          icon: const Icon(Icons.info_outlined),
                                          onPressed: () {
                                            showDeleteConfirmDialog();
                                          }),
                                    ],
                                  ),
                                  Center(
                                    child: Text(
                                      '下一站:$nextStop',
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontFamily: "oppoSansBold",
                                        // fontWeight: FontWeight.w900,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: NeumorphicButton(
                                    style: NeumorphicStyle(
                                      boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(10),
                                      ),
                                      // color: Colors.grey[200],
                                      color: const Color.fromARGB(
                                          250, 89, 151, 94),
                                      shape: NeumorphicShape.flat,
                                      intensity: 0,
                                    ),
                                    child: Container(
                                      color: const Color.fromARGB(
                                          250, 89, 151, 94),
                                      width: MediaQuery.of(context).size.width *
                                          0.30,
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          '当前人数:$passOnBus',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "oppoSansMedium",
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Center(
                                  child: NeumorphicButton(
                                    style: NeumorphicStyle(
                                      boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(10),
                                      ),
                                      // color: Colors.grey[200],
                                      color: Colors.blueAccent,
                                      intensity: 0,
                                      shape: NeumorphicShape.flat,
                                    ),
                                    child: Container(
                                      color: Colors.blueAccent,
                                      width: MediaQuery.of(context).size.width *
                                          0.30,
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          '待上车人数:$nextStopWaitingNum',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "oppoSansMedium",
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ]),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
