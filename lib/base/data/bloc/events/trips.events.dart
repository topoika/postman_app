import 'package:flutter/material.dart';

@immutable
abstract class TripsEvent {}

class FetchAllTripsEvent extends TripsEvent {}

class FetchRouteTripsEvent extends TripsEvent {}
