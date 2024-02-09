import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/views/components/universal.widgets.dart';

import '../../../data/bloc/events/shipments.event.dart';
import '../../../data/bloc/providers/shipment.provider.dart';
import '../../../data/bloc/state/shipments.state.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../../data/models/order.dart';
import '../../components/shipments/widget.dart';

class ShipmentsPage extends StatefulWidget {
  const ShipmentsPage({super.key});

  @override
  _ShipmentsPageState createState() => _ShipmentsPageState();
}

class _ShipmentsPageState extends StateMVC<ShipmentsPage> {
  ShipmentsBloc shipmentsBloc = ShipmentsBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    shipmentsBloc.add(FetchMyShipmentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/MorePage"),
          child: const Icon(
            Icons.sort,
            size: 32,
            color: Colors.black,
          ),
        ),
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
              'My Shipments',
              style: TextStyle(
                fontSize: 22,
                color: greenColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            BlocConsumer<ShipmentsBloc, ShipmentsState>(
              bloc: shipmentsBloc,
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.runtimeType) {
                  case ShipmentsLoadingState:
                    return const Center(child: CircularProgressIndicator());
                  case ShipmentsErrorState:
                    final error = state as ShipmentsErrorState;
                    return emptyWidget(context, error.message);
                  case ShipmentsLoadedState:
                    final suc = state as ShipmentsLoadedState;
                    return suc.shipments.isEmpty
                        ? emptyWidget(context, "No Shipments Found")
                        : myShipmentItems(context, suc.shipments);
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

Widget myShipmentItems(context, List<Order> shipments) => ListView.builder(
      shrinkWrap: true,
      itemCount: shipments.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final shipment = shipments[index];
        return shipmentItem(context, shipment);
      },
    );
