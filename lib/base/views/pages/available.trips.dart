import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../data/bloc/events/trips.events.dart';
import '../../data/bloc/providers/trips.provider.dart';
import '../../data/bloc/state/trips.state.dart';
import '../../data/controllers/trip.controller.dart';
import '../../data/helper/constants.dart';
import '../components/trips/trips.list.dart';
import '../components/universal.widgets.dart';

class AvailableTripsPage extends StatefulWidget {
  const AvailableTripsPage({super.key});

  @override
  _AvailableTripsPageState createState() => _AvailableTripsPageState();
}

class _AvailableTripsPageState extends StateMVC<AvailableTripsPage> {
  late TripController con;
  _AvailableTripsPageState() : super(TripController()) {
    con = controller as TripController;
  }
  TripsBloc tripsBloc = TripsBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    tripsBloc.add(FetchRouteTripsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: AppBar(
          leadingWidth: 68,
          backgroundColor: scafoldBlack,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: .4, color: Colors.grey)),
              child: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Trips",
            textScaleFactor: 1,
            style: TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),
          )),
      backgroundColor: scafoldBlack,
      body: RefreshIndicator(
        onRefresh: () async {
          init();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          physics: const ScrollPhysics(),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Available Trips',
                textScaleFactor: 1,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
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
                    return emptyWidget(context, 95, error.message);
                  case TripsLoadedState:
                    final suc = state as TripsLoadedState;
                    return Container(
                      child: suc.trips.isEmpty
                          ? emptyWidget(context, 95, "No Trips Found")
                          : tripsItems(context, suc.trips),
                    );
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
