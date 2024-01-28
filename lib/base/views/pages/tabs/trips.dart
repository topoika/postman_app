import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/bloc/events/trips.events.dart';
import '../../../data/bloc/providers/trips.provider.dart';
import '../../../data/bloc/state/trips.state.dart';
import '../../../data/controllers/trip.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../components/trips/trips.list.dart';
import '../../components/universal.widgets.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  _TripsPageState createState() => _TripsPageState();
}

class _TripsPageState extends StateMVC<TripsPage> {
  late TripController con;
  _TripsPageState() : super(TripController()) {
    con = controller as TripController;
  }
  TripsBloc tripsBloc = TripsBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    tripsBloc.add(FetchMyTripsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          appBarDate(),
          textScaleFactor: 1,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          init();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          children: [
            const Text(
              'My Trips',
              style: TextStyle(
                fontSize: 22,
                color: greenColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            BlocConsumer<TripsBloc, TripsState>(
              bloc: tripsBloc,
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.runtimeType) {
                  case TripsLoadingState:
                    return const Center(child: CircularProgressIndicator());
                  case TripsErrorState:
                    final error = state as TripsErrorState;
                    return emptyWidget(context, error.message);
                  case TripsLoadedState:
                    final suc = state as TripsLoadedState;
                    return suc.trips.isEmpty
                        ? emptyWidget(context, "No Trips Found")
                        : myTripsList(context, suc.trips);
                  default:
                    return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
