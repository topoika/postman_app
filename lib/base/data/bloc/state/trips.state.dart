import 'package:flutter/material.dart';

import '../../models/trip.dart';

@immutable
abstract class TripsState {}

class TripsInitial extends TripsState {}

class TripsLoadingState extends TripsState {}

class TripsErrorState extends TripsState {
  final String message;
  TripsErrorState(this.message);
}

class TripsLoadedState extends TripsState {
  final List<Trip> trips;
  TripsLoadedState({
    required this.trips,
  });
}
