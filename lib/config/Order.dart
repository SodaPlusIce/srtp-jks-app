import 'dart:convert';
import 'package:http/http.dart' as http;

class Order {
  // late String orderType;
  late String getCarLocation;
  late String destination;
  late int passengerNum;
  late String expected_on;

  // late DateTime getCarTime;
  Map toJson() {
    Map map = Map();
    map["stop_on"] = getCarLocation;
    map["stop_off"] = destination;
    map["passengers"] = passengerNum;
    map["expected_on"] = expected_on;

    return map;
  }
// Order(this.getCarLocation,this.destination,this.passengerNum);
  Order(this.getCarLocation,this.destination,this.passengerNum,this.expected_on);

}
