import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/helper/constants.dart';
import 'package:postman_app/base/data/models/package.dart';

import '../../data/bloc/events/trips.events.dart';
import '../../data/bloc/providers/trips.provider.dart';
import '../../data/bloc/state/trips.state.dart';
import '../../data/controllers/trip.controller.dart';
import '../../data/helper/helper.dart';
import '../components/trips/trips.list.dart';
import '../components/universal.widgets.dart';

class AvailableTripsPage extends StatefulWidget {
  final Package package;
  const AvailableTripsPage({super.key, required this.package});

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
    tripsBloc.add(FetchRouteTripsEvent(package: widget.package));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: BlackAppBar(
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            const Text(
              'Available Trips',
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: 20,
                color: greenColor,
                fontWeight: FontWeight.w700,
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
                        : tripsItems(context, suc.trips);

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
