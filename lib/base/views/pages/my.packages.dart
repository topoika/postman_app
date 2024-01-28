import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../data/bloc/events/packages.events.dart';
import '../../data/bloc/providers/package.provider.dart';
import '../../data/bloc/state/packages.state.dart';
import '../components/packages/packages.list.dart';
import '../components/universal.widgets.dart';

class MyPackagesPage extends StatefulWidget {
  const MyPackagesPage({super.key});

  @override
  _MyPackagesPageState createState() => _MyPackagesPageState();
}

class _MyPackagesPageState extends StateMVC<MyPackagesPage> {
  PackagesBloc packagesBloc = PackagesBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    packagesBloc.add(FetchMyPackagesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "My Packages"),
      body: RefreshIndicator(
        onRefresh: () async {
          init();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          children: [
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
                          ? emptyWidget(
                              context, "You don't have packages at the moment")
                          : packagesItems(context, suc.packages, mine: true),
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
