import 'package:flutter/material.dart';

@immutable
abstract class ExtrasEvent {}

class FetchFAQsEvent extends ExtrasEvent {}

class FetchFeeds extends ExtrasEvent {}
