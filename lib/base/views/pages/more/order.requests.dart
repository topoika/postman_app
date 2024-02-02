import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postman_app/base/data/bloc/state/request.state.dart';

import '../../../data/bloc/events/request.events.dart';
import '../../../data/bloc/providers/request.provier.dart';
import '../../components/packages/request.list.dart';
import '../../components/universal.widgets.dart';

class OrderRequestPage extends StatefulWidget {
  const OrderRequestPage({super.key});

  @override
  State<OrderRequestPage> createState() => _OrderRequestPageState();
}

class _OrderRequestPageState extends State<OrderRequestPage> {
  RequestsBloc requestsBloc = RequestsBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    requestsBloc.add(FetchMyRequestsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlackAppBar(
        title: const Text(
          "Order Requests",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
            const SizedBox(height: 8),
            BlocConsumer<RequestsBloc, RequestsState>(
              bloc: requestsBloc,
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.runtimeType) {
                  case RequestsLoadingState:
                    return const Center(child: CircularProgressIndicator());
                  case RequestsErrorState:
                    final error = state as RequestsErrorState;
                    return emptyWidget(context, error.message);
                  case RequestsLoadedState:
                    final suc = state as RequestsLoadedState;
                    return suc.requests.isEmpty
                        ? emptyWidget(context, "No Requests Found")
                        : requestItems(context, suc.requests);

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
