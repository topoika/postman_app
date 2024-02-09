import 'package:flutter/material.dart';

import '../../models/order.dart';

@immutable
abstract class ShipmentsState {}

class ShipmentsInitial extends ShipmentsState {}

class ShipmentsLoadingState extends ShipmentsState {}

class ShipmentsErrorState extends ShipmentsState {
  final String message;
  ShipmentsErrorState(this.message);
}

class ShipmentsLoadedState extends ShipmentsState {
  final List<Order> shipments;
  ShipmentsLoadedState({
    required this.shipments,
  });
}
