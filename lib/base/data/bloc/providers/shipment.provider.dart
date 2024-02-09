import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/order.dart';
import '../events/shipments.event.dart';
import '../repo/shipments.repo.dart';
import '../state/shipments.state.dart';

class ShipmentsBloc extends Bloc<ShipmentsEvent, ShipmentsState> {
  ShipmentsBloc() : super(ShipmentsInitial()) {
    on<FetchMyShipmentsEvent>(_fetchMyShipments);
  }

  Future<void> _fetchMyShipments(
      FetchMyShipmentsEvent event, Emitter<ShipmentsState> emit) async {
    emit(ShipmentsLoadingState());
    try {
      List<Order> shipments = await ShipmentsRepo.fetchMyShipments();

      emit(ShipmentsLoadedState(shipments: shipments));
    } catch (e) {
      print("State : $e");
      emit(ShipmentsErrorState(e.toString()));
    }
    return;
  }
}
