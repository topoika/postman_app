class Request {
  String? id;
  String? tripId;
  String? packageId;
  String? status;
  String? senderId;
  String? recieverId;
  double? postFee;
  bool? deleted;
  String? createdAt;
  Request({
    this.id,
    this.tripId,
    this.packageId,
    this.status,
    this.senderId,
    this.recieverId,
    this.postFee,
    this.deleted,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'packageId': packageId,
      'tripId': tripId,
      'status': status,
      'senderId': senderId,
      'recieverId': recieverId,
      'postFee': postFee,
      'deleted': deleted ?? false,
      'createdAt': createdAt,
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      id: map['id'] != null ? map['id'] as String : null,
      packageId: map['packageId'] != null ? map['packageId'] as String : null,
      tripId: map['tripId'] != null ? map['tripId'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      recieverId:
          map['recieverId'] != null ? map['recieverId'] as String : null,
      postFee: map['postFee'] != null ? map['postFee'] as double : null,
      deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}
