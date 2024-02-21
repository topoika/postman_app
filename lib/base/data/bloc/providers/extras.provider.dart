import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postman_app/base/data/bloc/repo/extras.repo.dart';

import '../../models/faq.dart';
import '../../models/feed.dart';
import '../events/extras.events.dart';
import '../state/extras.state.dart';

class ExtrasBloc extends Bloc<ExtrasEvent, ExtrasState> {
  ExtrasBloc() : super(ExtrasInitial()) {
    on<FetchFAQsEvent>(_fetcFAQs);
    on<FetchFeeds>(_fetcFeeds);
  }

  void _fetcFAQs(FetchFAQsEvent event, Emitter<ExtrasState> emit) async {
    emit(FAQsLoadingState());
    try {
      List<FAQ> faqs = await ExtrasRepo.fetchFAQs();

      emit(FAQsLoadedState(faqs: faqs));
    } catch (e) {
      print("State : $e");
      emit(FAQsErrorState(e.toString()));
    }
    return;
  }

  void _fetcFeeds(FetchFeeds event, Emitter<ExtrasState> emit) async {
    emit(FeedsLoadingState());
    try {
      List<Feed> feeds = await ExtrasRepo.fetchFeeds();

      emit(FeedsLoadedState(feeds: feeds));
    } catch (e) {
      print("State : $e");
      emit(FeedsErrorState(e.toString()));
    }
    return;
  }
}
