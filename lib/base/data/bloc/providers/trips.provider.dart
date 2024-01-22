import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/trip.dart';
import '../events/trips.events.dart';
import '../repo/trips.repo.dart';
import '../state/trips.state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  TripsBloc() : super(TripsInitial()) {
    on<FetchAllTripsEvent>(_fetchCategories);
    on<FetchRouteTripsEvent>(_fetchRouteTrip);
  }

  Future<void> _fetchCategories(
      FetchAllTripsEvent event, Emitter<TripsState> emit) async {
    emit(TripsLoadingState());
    try {
      List<Trip> trips = await TripsRepo.fetchTrips();

      emit(TripsLoadedState(trips: trips));
    } catch (e) {
      print("State : $e");
      emit(TripsErrorState(e.toString()));
    }
    return;
  }
  Future<void> _fetchRouteTrip(
      FetchRouteTripsEvent event, Emitter<TripsState> emit) async {
    emit(TripsLoadingState());
    try {
      List<Trip> trips = await TripsRepo.fetchRouteTrips();

      emit(TripsLoadedState(trips: trips));
    } catch (e) {
      print("State : $e");
      emit(TripsErrorState(e.toString()));
    }
    return;
  }
}
