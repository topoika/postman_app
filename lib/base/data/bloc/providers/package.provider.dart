import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/package.dart';
import '../events/packages.events.dart';
import '../repo/packages.repo.dart';
import '../state/packages.state.dart';

class PackagesBloc extends Bloc<PackagesEvent, PackagesState> {
  PackagesBloc() : super(PackagesInitial()) {
    on<FetchAllPackagesEvent>(_fetchAvailablePackages);
    on<FetchMyPackagesEvent>(_fetchMyPackages);
  }

  Future<void> _fetchAvailablePackages(
      FetchAllPackagesEvent event, Emitter<PackagesState> emit) async {
    emit(PackagesLoadingState());
    try {
      List<Package> packages = await PackagesRepo.fetchPackages();

      emit(PackagesLoadedState(packages: packages));
    } catch (e) {
      print("State : $e");
      emit(PackagesErrorState(e.toString()));
    }
    return;
  }

  Future<void> _fetchMyPackages(
      FetchMyPackagesEvent event, Emitter<PackagesState> emit) async {
    emit(PackagesLoadingState());
    try {
      List<Package> packages = await PackagesRepo.fetchMyPackages();

      emit(PackagesLoadedState(packages: packages));
    } catch (e) {
      print("State : $e");
      emit(PackagesErrorState(e.toString()));
    }
    return;
  }
}
