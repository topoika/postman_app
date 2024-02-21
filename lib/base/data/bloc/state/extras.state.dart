import 'package:flutter/material.dart';

import '../../models/faq.dart';
import '../../models/feed.dart';

@immutable
abstract class ExtrasState {}

class ExtrasInitial extends ExtrasState {}

// FAQS
class FAQsLoadingState extends ExtrasState {}

class FAQsErrorState extends ExtrasState {
  final String message;
  FAQsErrorState(this.message);
}

class FAQsLoadedState extends ExtrasState {
  final List<FAQ> faqs;
  FAQsLoadedState({
    required this.faqs,
  });
}

// FEEDS
class FeedsInitial extends ExtrasState {}

class FeedsLoadingState extends ExtrasState {}

class FeedsErrorState extends ExtrasState {
  final String message;
  FeedsErrorState(this.message);
}

class FeedsLoadedState extends ExtrasState {
  final List<Feed> feeds;
  FeedsLoadedState({
    required this.feeds,
  });
}
