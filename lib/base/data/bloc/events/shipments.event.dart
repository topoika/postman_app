import 'package:flutter/material.dart';

@immutable
abstract class ShipmentsEvent {}

class FetchAllShipmentsEvent extends ShipmentsEvent {}

class FetchMyShipmentsEvent extends ShipmentsEvent {}
