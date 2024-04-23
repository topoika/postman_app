import 'package:flutter/material.dart';

@immutable
abstract class RequestsEvent {}

class FetchMyRequestsEvent extends RequestsEvent {}

class FetchPackageRequestsEvent extends RequestsEvent {
  final String id;
  FetchPackageRequestsEvent(this.id);
}

class FetTripOrders extends RequestsEvent {
  final String id;
  FetTripOrders(this.id);
}

class FetOrderDetails extends RequestsEvent {
  final String id;
  FetOrderDetails(this.id);
}
