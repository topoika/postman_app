import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/bloc/events/trips.events.dart';
import 'package:postman_app/base/data/bloc/state/trips.state.dart';

import '../../../data/bloc/providers/trips.provider.dart';
import '../../../data/controllers/trip.controller.dart';
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
    tripsBloc.add(FetchAllTripsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => con.openDrawer(),
          child: const Icon(
            Icons.sort,
            size: 32,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Available  Trips Near You",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.notifications,
                size: 26,
                color: Colors.black,
              ),
            ),
          )
        ],
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
              'Trips in your zone',
              style: TextStyle(
                fontSize: 22,
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
                    return emptyWidget(context, 95, error.message);
                  case TripsLoadedState:
                    final suc = state as TripsLoadedState;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15)
                          .copyWith(left: 11),
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
