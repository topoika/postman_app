import 'package.dart';
import 'travel.method.dart';
import 'user.dart';

class Order {
  String? id;
  String? orderID;
  double? postManFee;
  double? tipAmount;
  double? totalAmount;
  TravelMethod? travelMethod;
  String? tripId;
  Package? package;
  User? postMan;
  String? senderId;
  String? postmanId;
  String? status;
  String? createdAt;
  String? packageDeliverdAt;
  String? postManReceivedAt;
  Order({
    this.id,
    this.orderID,
    this.postManFee,
    this.tipAmount,
    this.totalAmount,
    this.travelMethod,
    this.tripId,
    this.package,
    this.postMan,
    this.senderId,
    this.postmanId,
    this.status,
    this.createdAt,
    this.packageDeliverdAt,
    this.postManReceivedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderID': orderID,
      'postManFee': postManFee,
      'tipAmount': tipAmount,
      'totalAmount': totalAmount,
      'travelMethod': travelMethod?.id,
      'tripId': tripId,
      'package': package?.toMap(),
      'postMan': postMan?.toMap(),
      'senderId': senderId,
      'postmanId': postmanId,
      'status': status,
      'createdAt': createdAt,
      'packageDeliverdAt': packageDeliverdAt,
      'postManReceivedAt': postManReceivedAt,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] != null ? map['id'] as String : null,
      orderID: map['orderID'] != null ? map['orderID'] as String : null,
      postManFee:
          map['postManFee'] != null ? map['postManFee'] as double : null,
      tipAmount: map['tipAmount'] != null ? map['tipAmount'] as double : null,
      totalAmount:
          map['totalAmount'] != null ? map['totalAmount'] as double : null,
      travelMethod: map['travelMethod'] != null
          ? travelMethods.firstWhere((i) => i.id == map['travelMethod'])
          : null,
      tripId: map['tripId'] != null ? map['tripId'] as String : null,
      package: map['package'] != null
          ? Package.fromMap(map['package'] as Map<String, dynamic>)
          : null,
      postMan: map['postMan'] != null
          ? User.fromMap(map['postMan'] as Map<String, dynamic>)
          : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      postmanId: map['postmanId'] != null ? map['postmanId'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      packageDeliverdAt: map['packageDeliverdAt'] != null
          ? map['packageDeliverdAt'] as String
          : null,
      postManReceivedAt: map['postManReceivedAt'] != null
          ? map['postManReceivedAt'] as String
          : null,
    );
  }
}
