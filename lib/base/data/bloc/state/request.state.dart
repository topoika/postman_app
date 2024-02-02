import 'package:flutter/material.dart';

import '../../models/request.dart';

@immutable
abstract class RequestsState {}

class RequestsInitial extends RequestsState {}

class RequestsLoadingState extends RequestsState {}

class RequestsErrorState extends RequestsState {
  final String message;
  RequestsErrorState(this.message);
}

class RequestsLoadedState extends RequestsState {
  final List<Request> requests;
  RequestsLoadedState({
    required this.requests,
  });
}
