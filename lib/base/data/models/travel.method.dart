class TravelMethod {
  int? id;
  String? name;
  String? icon;
  TravelMethod({
    this.id,
    this.name,
    this.icon,
  });
}

List<TravelMethod> travelMethods = [
  TravelMethod(id: 1, name: "Airplane", icon: "airplane.png"),
  TravelMethod(id: 2, name: "Bus", icon: "bus.png"),
  TravelMethod(id: 3, name: "Car", icon: "car.png"),
  TravelMethod(id: 4, name: "Train", icon: "train.png"),
  TravelMethod(id: 5, name: "Bike", icon: "bike.png"),
  TravelMethod(id: 6, name: "Van", icon: "van.png"),
];
