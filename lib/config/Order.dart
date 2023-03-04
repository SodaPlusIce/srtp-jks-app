import 'dart:convert';
import 'package:http/http.dart' as http;

class Order {
  late String orderType;
  late String getCarLocation;
  late String destination;
  late int passengerNum;
  late DateTime getCarTime;

  Order.fromJson(Map<String, dynamic> json) {
    orderType = json['name'];
    getCarLocation = json['getCarLocation'];
    destination = json['destination'];
    passengerNum = json['passengerNum'];
    getCarTime = json['getCarTime'];
  }
}
