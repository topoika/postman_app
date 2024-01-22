import 'package:flutter/material.dart';

@immutable
abstract class PackagesEvent {}

class FetchAllPackagesEvent extends PackagesEvent {}

class FetchMyPackagesEvent extends PackagesEvent {}
