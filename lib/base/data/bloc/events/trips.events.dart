// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../models/package.dart';

@immutable
abstract class TripsEvent {}

class FetchAllTripsEvent extends TripsEvent {}

class FetchMyTripsEvent extends TripsEvent {}

class FetchRouteTripsEvent extends TripsEvent {
  final Package package;
  FetchRouteTripsEvent({
    required this.package,
  });
}
