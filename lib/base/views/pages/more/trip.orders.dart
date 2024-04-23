// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/bloc/providers/request.provier.dart';
import '../../../data/bloc/state/request.state.dart';
import '../../../data/controllers/order.controller.dart';
import '../../components/packages/request.list.dart';
import '../../components/universal.widgets.dart';

class TripOrders extends StatefulWidget {
  final String id;
  const TripOrders({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _TripOrdersState createState() => _TripOrdersState();
}

class _TripOrdersState extends StateMVC<TripOrders> {
  late OrderController con;
  _TripOrdersState() : super(OrderController()) {
    con = controller as OrderController;
  }

  @override
  void initState() {
    super.initState();
    con.initOrders(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: BlackAppBar(
        title: const Text(
          "Trip Orders",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          con.initOrders(widget.id);
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            const SizedBox(height: 8),
            BlocConsumer<RequestsBloc, RequestsState>(
              bloc: con.ordersBloc,
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.runtimeType) {
                  case RequestsLoadingState:
                    return const Center(child: CircularProgressIndicator());
                  case RequestsErrorState:
                    final error = state as RequestsErrorState;
                    return emptyWidget(context, error.message);
                  case TrioOrderLoaded:
                    final suc = state as TrioOrderLoaded;
                    return suc.orders.isEmpty
                        ? emptyWidget(context, "No Orders Found")
                        : tripOrderList(context, suc.orders, con);
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
