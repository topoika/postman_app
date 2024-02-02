import 'package:flutter/material.dart';

@immutable
abstract class RequestsEvent {}

class FetchMyRequestsEvent extends RequestsEvent {}
