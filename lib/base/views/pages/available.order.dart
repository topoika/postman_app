import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/bloc/events/packages.events.dart';
import '../../data/bloc/providers/package.provider.dart';
import '../../data/bloc/state/packages.state.dart';
import '../components/packages/packages.list.dart';
import '../components/universal.widgets.dart';

class AvailableOrdersPage extends StatefulWidget {
  const AvailableOrdersPage({super.key});

  @override
  State<AvailableOrdersPage> createState() => _AvailableOrdersPageState();
}

class _AvailableOrdersPageState extends State<AvailableOrdersPage> {
  PackagesBloc packagesBloc = PackagesBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    packagesBloc.add(FetchAllPackagesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Available Orders"),
      body: RefreshIndicator(
        onRefresh: () async {
          init();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          children: [
            const Text(
              'Packages in your zone',
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            BlocConsumer<PackagesBloc, PackagesState>(
              bloc: packagesBloc,
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.runtimeType) {
                  case PackagesLoadingState:
                    return const Center(child: CircularProgressIndicator());
                  case PackagesErrorState:
                    final error = state as PackagesErrorState;
                    return emptyWidget(context, error.message);
                  case PackagesLoadedState:
                    final suc = state as PackagesLoadedState;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15)
                          .copyWith(left: 11),
                      child: suc.packages.isEmpty
                          ? emptyWidget(context, "No Packages Found")
                          : packagesItems(context, suc.packages),
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
