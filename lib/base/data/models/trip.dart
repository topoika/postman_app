import 'address.dart';
import 'travel.method.dart';
import 'user.dart';

class Trip {
  String? id;
  String? travellerIs;
  VehicleDetails? vehicleDetails;
  DepartureDetails? departureDetails;
  DepartureDetails? destinationDetails;
  TrainDetails? trainDetails;
  PlaneDetails? planDetails;
  String? packagePrefernces;
  String? guideToMeet;
  String? ticketUrl;
  TravelMethod? travelMethod;
  double? postageFee;
  User? traveller;
  String? travellersId;
  String? travelledAt;
  bool? available;
  String? status;
  String? createdAt;
  String? updatedAt;

  // Extras

  String? city;
  String? time;
  Trip({
    this.id,
    this.travellerIs,
    this.vehicleDetails,
    this.departureDetails,
    this.destinationDetails,
    this.packagePrefernces,
    this.guideToMeet,
    this.ticketUrl,
    this.trainDetails,
    this.planDetails,
    this.travelMethod,
    this.postageFee,
    this.traveller,
    this.travellersId,
    this.travelledAt,
    this.available,
    this.status,
    this.createdAt,
    this.updatedAt,

    // Extras
    this.city,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'travellerIs': travellerIs,
      'vehicleDetails': vehicleDetails?.toMap(),
      'departureDetails': departureDetails?.toMap(),
      'destinationDetails': destinationDetails?.toMap(),
      'trainDetails': trainDetails?.toMap(),
      'planDetails': planDetails?.toMap(),
      'traveller': traveller?.toMap(),
      'packagePrefernces': packagePrefernces,
      'guideToMeet': guideToMeet,
      'ticketUrl': ticketUrl,
      'travelMethod': travelMethod?.id,
      'postageFee': postageFee,
      'travellersId': travellersId,
      'travelledAt': travelledAt,
      'available': available,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,

      // extras
    };
  }

  Map<String, dynamic> toMessageMap() {
    return <String, dynamic>{
      'id': id,
      'city': departureDetails!.address!.city,
      'time': departureDetails!.time,
      'travelMethod': travelMethod?.id,
    };
  }

  factory Trip.fromMessageMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] != null ? map['id'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      travelMethod: map['travelMethod'] != null
          ? travelMethods.firstWhere((i) => i.id == map['travelMethod'])
          : null,
    );
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] != null ? map['id'] as String : null,
      travellerIs:
          map['travellerIs'] != null ? map['travellerIs'] as String : null,
      vehicleDetails: map['vehicleDetails'] != null
          ? VehicleDetails.fromMap(
              map['vehicleDetails'] as Map<String, dynamic>)
          : null,
      departureDetails: map['departureDetails'] != null
          ? DepartureDetails.fromMap(
              map['departureDetails'] as Map<String, dynamic>)
          : null,
      destinationDetails: map['destinationDetails'] != null
          ? DepartureDetails.fromMap(
              map['destinationDetails'] as Map<String, dynamic>)
          : null,
      trainDetails: map['trainDetails'] != null
          ? TrainDetails.fromMap(map['trainDetails'] as Map<String, dynamic>)
          : null,
      planDetails: map['planDetails'] != null
          ? PlaneDetails.fromMap(map['planDetails'] as Map<String, dynamic>)
          : null,
      traveller: map['traveller'] != null
          ? User.fromMap(map['traveller'] as Map<String, dynamic>)
          : null,
      packagePrefernces: map['packagePrefernces'] != null
          ? map['packagePrefernces'] as String
          : null,
      guideToMeet:
          map['guideToMeet'] != null ? map['guideToMeet'] as String : null,
      ticketUrl: map['ticketUrl'] != null ? map['ticketUrl'] as String : null,
      travelMethod: map['travelMethod'] != null
          ? travelMethods.firstWhere((i) => i.id == map['travelMethod'])
          : null,
      postageFee:
          map['postageFee'] != null ? map['postageFee'] as double : null,
      travellersId:
          map['travellersId'] != null ? map['travellersId'] as String : null,
      travelledAt:
          map['travelledAt'] != null ? map['travelledAt'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      available: map['available'] != null ? map['available'] as bool : null,
    );
  }
}

class VehicleDetails {
  String? vehicleIdentity;
  String? transportCompany;
  String? vehicleLicencePlate;
  VehicleDetails({
    this.vehicleIdentity,
    this.transportCompany,
    this.vehicleLicencePlate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicleIdentity': vehicleIdentity,
      'transportCompany': transportCompany,
      'vehicleLicencePlate': vehicleLicencePlate,
    };
  }

  factory VehicleDetails.fromMap(Map<String, dynamic> map) {
    return VehicleDetails(
      vehicleIdentity: map['vehicleIdentity'] != null
          ? map['vehicleIdentity'] as String
          : null,
      transportCompany: map['transportCompany'] != null
          ? map['transportCompany'] as String
          : null,
      vehicleLicencePlate: map['vehicleLicencePlate'] != null
          ? map['vehicleLicencePlate'] as String
          : null,
    );
  }
}

class TrainDetails {
  String? trainName;
  String? trainNumber;
  TrainDetails({
    this.trainName,
    this.trainNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trainName': trainName,
      'trainNumber': trainNumber,
    };
  }

  factory TrainDetails.fromMap(Map<String, dynamic> map) {
    return TrainDetails(
      trainName: map['trainName'] != null ? map['trainName'] as String : null,
      trainNumber:
          map['trainNumber'] != null ? map['trainNumber'] as String : null,
    );
  }
}

class PlaneDetails {
  String? planeName;
  String? planeNumber;
  PlaneDetails({
    this.planeName,
    this.planeNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'planeName': planeName,
      'planeNumber': planeNumber,
    };
  }

  factory PlaneDetails.fromMap(Map<String, dynamic> map) {
    return PlaneDetails(
      planeName: map['planeName'] != null ? map['planeName'] as String : null,
      planeNumber:
          map['planeNumber'] != null ? map['planeNumber'] as String : null,
    );
  }
}

class DepartureDetails {
  Address? address;
  String? meetUpPlace;
  String? date;
  String? time;
  DepartureDetails({
    this.address,
    this.meetUpPlace,
    this.date,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address?.toMap(),
      'meetUpPlace': meetUpPlace,
      'date': date,
      'time': time,
    };
  }

  factory DepartureDetails.fromMap(Map<String, dynamic> map) {
    return DepartureDetails(
      address: map['address'] != null
          ? Address.fromMap(map['address'] as Map<String, dynamic>)
          : null,
      meetUpPlace:
          map['meetUpPlace'] != null ? map['meetUpPlace'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
    );
  }
}
