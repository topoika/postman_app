import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/request.dart';
import '../events/request.events.dart';
import '../repo/request.repo.dart';
import '../state/request.state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  RequestsRepo repo = RequestsRepo();
  RequestsBloc() : super(RequestsInitial()) {
    on<FetchMyRequestsEvent>(_fetchMyRequests);
    on<FetchPackageRequestsEvent>(_fetchPackageRequests);
    on<FetTripOrders>(fetchTripOrders);
    on<FetOrderDetails>(fetchOrderDetails);
  }

  Future<void> _fetchMyRequests(
      FetchMyRequestsEvent event, Emitter<RequestsState> emit) async {
    emit(RequestsLoadingState());
    try {
      List<Request> requests = await repo.fetchMyRequests();
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
  }

  // fetch trip orders
  Future<void> fetchTripOrders(FetTripOrders event, emit) async {
    emit(RequestsLoadingState());
    try {
      final orders = await repo.fetchTripOrders(event.id);
      emit(TrioOrderLoaded(orders: orders));
    } catch (e) {
      print("State : $e");
      emit(RequestsErrorState(e.toString()));
    }
  }

  // fetch trip orders
  Future<void> fetchOrderDetails(FetOrderDetails event, emit) async {
    emit(RequestsLoadingState());
    try {
      final order = await repo.fetchOrderDetails(event.id);
      emit(OrderLoaded(order: order));
    } catch (e) {
      print("State : $e");
      emit(RequestsErrorState(e.toString()));
    }
  }
}
