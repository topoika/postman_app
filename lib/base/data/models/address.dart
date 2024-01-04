class Address {
  String? country;
  String? state;
  String? address;
  String? nameAddress;
  String? city;
  double? latitude;
  double? longitude;
  Address({
    this.country,
    this.state,
    this.address,
    this.city,
    this.nameAddress,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'state': state,
      'address': address,
      'nameAddress': nameAddress,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      country: map['country'] != null ? map['country'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      nameAddress:
          map['nameAddress'] != null ? map['nameAddress'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
    );
  }
}
