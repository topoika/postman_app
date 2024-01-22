import 'package:flutter/material.dart';

import '../helper/constants.dart';

class TravelMethod {
  int? id;
  String? name;
  String? icon;
  Color? color;
  TravelMethod({
    this.id,
    this.name,
    this.icon,
    this.color,
  });
}

List<TravelMethod> travelMethods = [
  TravelMethod(
    id: 1,
    name: "Airplane",
    icon: "airplane.png",
    color: const Color(0xff6B68FF),
  ),
  TravelMethod(
    id: 2,
    name: "Bus",
    icon: "bus.png",
    color: const Color(0xff01CAFE),
  ),
  TravelMethod(id: 3, name: "Car", icon: "car.png", color: greenColor),
  TravelMethod(
    id: 4,
    name: "Train",
    icon: "train.png",
    color: const Color.fromARGB(255, 6, 4, 102),
  ),
  TravelMethod(
      id: 5, name: "Bike", icon: "bike.png", color: const Color(0xffFF7F00)),
  TravelMethod(
    id: 6,
    name: "Van",
    icon: "van.png",
    color: const Color.fromARGB(255, 187, 5, 5),
  ),
];
