import 'dart:convert';
import 'package:http/http.dart' as http;

class Order {
  // late String orderType;
  late String getCarLocation;
  late String destination;
  late int passengerNum;
  // late DateTime getCarTime;
  Map toJson() {
    Map map = Map();
    map["stop_on"] = getCarLocation;
    map["stop_off"] = destination;
    map["passengers"] = passengerNum;
    return map;
  }
Order(this.getCarLocation,this.destination,this.passengerNum);
}
