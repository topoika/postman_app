// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package.dart';
import 'travel.method.dart';
import 'user.dart';

class Order {
  String? id;
  String? requestId;
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

  // card
  Payment? payment;
  Order({
    this.id,
    this.requestId,
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
    this.payment,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'requestId': requestId,
      'postManFee': postManFee,
      'tipAmount': tipAmount,
      'totalAmount': totalAmount,
      'travelMethod': travelMethod?.id,
      'tripId': tripId,
      'package': package?.toMap(),
      'postMan': postMan?.toMap(),
      'payment': payment?.toMap(),
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
      requestId: map['requestId'] != null ? map['requestId'] as String : null,
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

class Payment {
  String? holdersName;
  String? cardNumber;
  String? expiry;
  String? cvc;
  String? status;
  Payment({
    this.holdersName,
    this.cardNumber,
    this.expiry,
    this.cvc,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'holdersName': holdersName,
      'cardNumber': cardNumber,
      'expiry': expiry,
      'status': status,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      holdersName:
          map['holdersName'] != null ? map['holdersName'] as String : null,
      cardNumber:
          map['cardNumber'] != null ? map['cardNumber'] as String : null,
      expiry: map['expiry'] != null ? map['expiry'] as String : null,
      cvc: map['status'] != null ? map['status'] as String : null,
    );
  }
}
