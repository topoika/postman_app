import 'package:flutter/material.dart';

import '../../models/package.dart';

@immutable
abstract class PackagesState {}

class PackagesInitial extends PackagesState {}

class PackagesLoadingState extends PackagesState {}

class PackagesErrorState extends PackagesState {
  final String message;
  PackagesErrorState(this.message);
}

class PackagesLoadedState extends PackagesState {
  final List<Package> packages;
  PackagesLoadedState({
    required this.packages,
  });
}
