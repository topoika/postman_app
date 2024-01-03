import 'address.dart';

class Package {
  String? id;
  String? senderId;
  String? postManId;
  String? name;
  double? value;
  List<String>? image;
  bool? insurance;
  bool? packBySender;
  String? description;
  String? weight;
  double? dimLength;
  double? dimWidth;
  double? dimHeight;
  Address? shipmentAddress;
  Address? destinationAddress;
  String? date;
  String? createAt;
  String? updatedAt;
  UserDetails? userDetails;
  Package({
    this.id,
    this.senderId,
    this.postManId,
    this.name,
    this.value,
    this.image,
    this.insurance,
    this.packBySender,
    this.description,
    this.weight,
    this.dimLength,
    this.dimWidth,
    this.dimHeight,
    this.shipmentAddress,
    this.destinationAddress,
    this.date,
    this.createAt,
    this.updatedAt,
    this.userDetails,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderId': senderId,
      'postManId': postManId,
      'name': name,
      'value': value,
      'image': image,
      'insurance': insurance,
      'packBySender': packBySender,
      'description': description,
      'weight': weight,
      'dimLength': dimLength,
      'dimWidth': dimWidth,
      'dimHeight': dimHeight,
      'shipmentAddress': shipmentAddress?.toMap(),
      'destinationAddress': destinationAddress?.toMap(),
      'date': date,
      'createAt': createAt,
      'updatedAt': updatedAt,
      'userDetails': userDetails?.toMap(),
    };
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    return Package(
      id: map['id'] != null ? map['id'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      postManId: map['postManId'] != null ? map['postManId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      value: map['value'] != null ? map['value'] as double : null,
      image: map['image'] != null
          ? List<String>.from((map['image'] as List<String>))
          : null,
      insurance: map['insurance'] != null ? map['insurance'] as bool : null,
      packBySender:
          map['packBySender'] != null ? map['packBySender'] as bool : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      weight: map['weight'] != null ? map['weight'] as String : null,
      dimLength: map['dimLength'] != null ? map['dimLength'] as double : null,
      dimWidth: map['dimWidth'] != null ? map['dimWidth'] as double : null,
      dimHeight: map['dimHeight'] != null ? map['dimHeight'] as double : null,
      shipmentAddress: map['shipmentAddress'] != null
          ? Address.fromMap(map['shipmentAddress'] as Map<String, dynamic>)
          : null,
      destinationAddress: map['destinationAddress'] != null
          ? Address.fromMap(map['destinationAddress'] as Map<String, dynamic>)
          : null,
      date: map['date'] != null ? map['date'] as String : null,
      createAt: map['createAt'] != null ? map['createAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      userDetails: map['userDetails'] != null
          ? UserDetails.fromMap(map['userDetails'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UserDetails {
  String? senderName;
  String? senderMobile;
  String? recieverName;
  String? recieverMobile;
  String? recieverALtMobile;
  String? noteToPostman;
  UserDetails({
    this.senderName,
    this.senderMobile,
    this.recieverName,
    this.recieverMobile,
    this.recieverALtMobile,
    this.noteToPostman,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderName': senderName,
      'senderMobile': senderMobile,
      'recieverName': recieverName,
      'recieverMobile': recieverMobile,
      'recieverALtMobile': recieverALtMobile,
      'noteToPostman': noteToPostman,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      senderName:
          map['senderName'] != null ? map['senderName'] as String : null,
      senderMobile:
          map['senderMobile'] != null ? map['senderMobile'] as String : null,
      recieverName:
          map['recieverName'] != null ? map['recieverName'] as String : null,
      recieverMobile: map['recieverMobile'] != null
          ? map['recieverMobile'] as String
          : null,
      recieverALtMobile: map['recieverALtMobile'] != null
          ? map['recieverALtMobile'] as String
          : null,
      noteToPostman:
          map['noteToPostman'] != null ? map['noteToPostman'] as String : null,
    );
  }
}
