import 'package:flutter/material.dart';

@immutable
abstract class RequestsEvent {}

class FetchMyRequestsEvent extends RequestsEvent {}

class FetchPackageRequestsEvent extends RequestsEvent {
  final String id;
  FetchPackageRequestsEvent(this.id);
}
