import 'address.dart';

class User {
  String? id;
  String? username;
  String? image;
  String? email;
  String? password;
  Address? address;
  String? phone;
  String? passport;
  String? governmentId;
  String? idNumber;
  bool? idVerified;
  bool? isAdmin;
  String? deviceToken;
  String? createdAt;
  String? updtedAt;
  User({
    this.id,
    this.username,
    this.image,
    this.email,
    this.password,
    this.address,
    this.phone,
    this.passport,
    this.governmentId,
    this.idNumber,
    this.isAdmin,
    this.deviceToken,
    this.idVerified,
    this.createdAt,
    this.updtedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'image': image,
      'email': email,
      'address': address!.toMap(),
      'phone': phone,
      'passport': passport,
      'governmentId': governmentId,
      'idNumber': idNumber,
      'deviceToken': deviceToken,
      'idVerified': idVerified,
      'isAdmin': isAdmin ?? false,
      'createdAt': createdAt,
      'updtedAt': updtedAt ?? DateTime.now().toString(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      address: map['address'] != null
          ? Address.fromMap(map['address'] as Map<String, dynamic>)
          : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      passport: map['passport'] != null ? map['passport'] as String : null,
      deviceToken:
          map['deviceToken'] != null ? map['deviceToken'] as String : null,
      isAdmin: map['isAdmin'] != null ? map['isAdmin'] as bool : null,
      idVerified: map['idVerified'] != null ? map['idVerified'] as bool : null,
      governmentId:
          map['governmentId'] != null ? map['governmentId'] as String : null,
      idNumber: map['idNumber'] != null ? map['idNumber'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updtedAt: map['updtedAt'] != null ? map['updtedAt'] as String : null,
    );
  }
}
