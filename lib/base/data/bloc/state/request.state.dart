import 'package:flutter/material.dart';

import '../../models/order.dart';
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

class TrioOrderLoaded extends RequestsState {
  final List<Order> orders;
  TrioOrderLoaded({
    required this.orders,
  });
}

class OrderLoaded extends RequestsState {
  final Order order;
  OrderLoaded({
    required this.order,
  });
}
