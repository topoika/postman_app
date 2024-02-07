import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/request.dart';
import '../events/request.events.dart';
import '../repo/request.repo.dart';
import '../state/request.state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  RequestsBloc() : super(RequestsInitial()) {
    on<FetchMyRequestsEvent>(_fetchMyRequests);
    on<FetchPackageRequestsEvent>(_fetchPackageRequests);
  }

  Future<void> _fetchMyRequests(
      FetchMyRequestsEvent event, Emitter<RequestsState> emit) async {
    emit(RequestsLoadingState());
    try {
      List<Request> requests = await RequestsRepo.fetchMyRequests();
      emit(RequestsLoadedState(requests: requests));
    } catch (e) {
      print("State : $e");
      emit(RequestsErrorState(e.toString()));
    }
    return;
  }

  Future<void> _fetchPackageRequests(
      FetchPackageRequestsEvent event, Emitter<RequestsState> emit) async {
    emit(RequestsLoadingState());
    try {
      List<Request> requests =
          await RequestsRepo.fetchPackageRequests(event.id);
      emit(RequestsLoadedState(requests: requests));
    } catch (e) {
      print("State : $e");
      emit(RequestsErrorState(e.toString()));
    }
    return;
  }
}
