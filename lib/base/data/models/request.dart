import 'trip.dart';

class Request {
  String? id;
  Trip? trip;
  String? packageId;
  String? status;
  String? recieverId;
  String? senderId;
  String? senderName;
  double? postFee;
  bool? deleted;
  String? createdAt;
  String? travelledAt;
  Request({
    this.id,
    this.trip,
    this.packageId,
    this.status,
    this.recieverId,
    this.senderId,
    this.senderName,
    this.postFee,
    this.deleted,
    this.createdAt,
    this.travelledAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'trip': trip?.toMap(),
      'packageId': packageId,
      'status': status,
      'recieverId': recieverId,
      'senderId': senderId,
      'senderName': senderName,
      'postFee': postFee,
      'deleted': deleted ?? false,
      'createdAt': createdAt,
      'tripId': trip?.id,
      'travelledAt': travelledAt,
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      id: map['id'] != null ? map['id'] as String : null,
      trip: map['trip'] != null
          ? Trip.fromMap(map['trip'] as Map<String, dynamic>)
          : null,
      packageId: map['packageId'] != null ? map['packageId'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      recieverId:
          map['recieverId'] != null ? map['recieverId'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      senderName:
          map['senderName'] != null ? map['senderName'] as String : null,
      postFee: map['postFee'] != null
          ? double.parse(map['postFee'].toString())
          : null,
      deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      travelledAt:
          map['travelledAt'] != null ? map['travelledAt'] as String : null,
    );
  }
}
