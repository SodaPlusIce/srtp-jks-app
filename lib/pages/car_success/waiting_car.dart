import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../config/config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

const String netip = "http://10.0.2.2:5000";
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

class WaitingCarPage extends StatefulWidget {
  const WaitingCarPage({Key? key}) : super(key: key);

  @override
  State<WaitingCarPage> createState() => _WaitingCarPageState();
}

class _WaitingCarPageState extends State<WaitingCarPage> {
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
  var title = "智慧公交——等候公交车";
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

  /// 步骤x相关数据
  int _stepIndex = 0;
  final List<String> _stepName = <String>["步骤一", "步骤二", "步骤三", "步骤四"];

  /// 上车人数
  int _passNum = 1;

  @override
  void initState() {
    super.initState();
    _mapType = MapType.navi;

    /// 设置Android和iOS的apikey，
    AMapFlutterLocation.setApiKey(ConstConfig.androidKey, ConstConfig.iosKey);

    /// 设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyShow(true, true);
    // requestPermission();
  }

  /// 请求位置

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
  }

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

  /// 弹出"选择出行方式"旁的info按钮对应的对话框
  Future<bool?> showDeleteConfirmDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("提示"),
          content: const Text("当前距离项每一分钟自动刷新，并非实时更新\n"
              "如需要获取实时定位需要手动刷新\n"),
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

  /// 调用接口： getOrderInfo
  Future<void> getOrderInfo() async {
    String url = "$netip/getOrderInfo";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      print(res.body);
    } else {
      print("Failed to get data.~~~");
      // 做出提示，网络连接有问题
    }
  }

  /// 调用接口： addOrder
  Future<void> addOrder() async {
    String url = "$netip/addOrder";
    var res = await http.post(Uri.parse(url), body: {});
    if (res.statusCode == 200) {
      print(res.body);
    } else {
      print("Failed to get data.~~~");
    }
  }

  @override
  Widget build(BuildContext context) {
    _addMarker(); //添加各站点的marker
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(250, 87, 150, 92),
          title: const Text("智慧公交--等待公交车")),
      body: GFFloatingWidget(
        //垂直偏移量
        // verticalPosition: MediaQuery.of(context).size.height * 0.01,
        // // 水平偏移量
        // horizontalPosition: MediaQuery.of(context).size.width * 0.01,
        //正文内容
        body: AMapWidget(
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
        // const SizedBox(height: 1,),
        //背景是否模糊
        // showBlurness: true,
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
                            color: Color.fromARGB(255, 249, 215, 138),
                            shadowColor:
                                const Color.fromARGB(250, 231, 241, 251),
                            elevation: 20,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(height: 30,),
                                     Padding(
                                        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.7, 0, 0, 0)),
                                    IconButton(
                                        padding: const EdgeInsets.all(0),
                                        icon:
                                        const Icon(Icons.info_outlined),
                                        onPressed: () {
                                          showDeleteConfirmDialog();
                                        }),
                                  ],
                                ),
                                const  Center(
                                  child: Text(
                                    '当前距离5000m',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30,),
                              ],
                            )
                            ),
                         const SizedBox(height: 10,),
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            color: const Color.fromARGB(250, 250, 252, 254),
                              shadowColor:
                              const Color.fromARGB(250, 231, 241, 251),
                              elevation: 20,
                              child: Center(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: NeumorphicButton(
                                        style: NeumorphicStyle(
                                          boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(20),
                                          ),
                                          // color: Colors.grey[200],
                                          color: Colors.green,
                                          shape: NeumorphicShape.flat,
                                        ),
                                        child: Container(
                                          color: Colors.green,
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          height: 60,
                                          child: const Center(
                                            child: Text(
                                              '刷新',
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    const SizedBox(width: 3,),
                                    Center(
                                      child: NeumorphicButton(
                                        style: NeumorphicStyle(
                                          boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(20),
                                          ),
                                          // color: Colors.grey[200],
                                          color: Colors.red,
                                          shape: NeumorphicShape.flat,
                                        ),
                                        child: Container(
                                          color: Colors.red,
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          height: 60,
                                          child: const Center(
                                            child: Text(
                                              '取消订单',
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ) ,
                              ),
                          ),
                          const SizedBox(height: 10,),




                        ]),
                    // 步骤一：选择出行方式
                    // 步骤二：预约出行
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
