// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/models/package.dart';

import '../../../data/bloc/events/request.events.dart';
import '../../../data/bloc/providers/request.provier.dart';
import '../../../data/bloc/state/request.state.dart';
import '../../../data/controllers/order.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/models/order.dart';
import '../../components/buttons.dart';
import '../../components/packages/image.slider.dart';
import '../../components/universal.widgets.dart';
import '../package/package.details.dart';

class ShipmentDetails extends StatefulWidget {
  final String id;
  const ShipmentDetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _ShipmentDetailsState createState() => _ShipmentDetailsState();
}

class _ShipmentDetailsState extends StateMVC<ShipmentDetails> {
  late OrderController con;
  _ShipmentDetailsState() : super(OrderController()) {
    con = controller as OrderController;
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    con.orderBloc.add(FetOrderDetails(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: BlackAppBar(
        title: const Text(
          "Order Details",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          init();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: BlocConsumer<RequestsBloc, RequestsState>(
          bloc: con.orderBloc,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case RequestsLoadingState:
                return const Center(child: CircularProgressIndicator());
              case RequestsErrorState:
                final error = state as RequestsErrorState;
                return emptyWidget(context, error.message);
              case OrderLoaded:
                final suc = state as OrderLoaded;
                return orderDetailsPage(context, con, suc.order, init);

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

Widget orderDetailsPage(context, OrderController con, Order order, refresh) {
  Package package = order.package!;
  return Column(
    children: [
      Expanded(
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            SliderWithIndicators(images: package.images),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          package.name ?? "",
                          textScaleFactor: 1,
                          style: const TextStyle(
                            color: greenColor,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Item# ${package.id!.substring(0, 7)}",
                          textScaleFactor: 1,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    margin: const EdgeInsets.only(top: 15, bottom: 25),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(.06),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Payment Status",
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          order.payment?.status ?? "",
                          textScaleFactor: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: greenColor,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                  dimensions(context, package),
                  subheading("Note to Postman"),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(.06),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            package.userDetails!.noteToPostman ?? "",
                            textScaleFactor: 1,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  subheading("Description"),
                  Text(
                    package.description!,
                    textScaleFactor: 1,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                  packageDetails(context, package, false),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
        child: Column(
          children: <Widget>[
            Visibility(
              visible: order.status == "pending",
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Text(
                    'Have you collected the package from customer?',
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                          child: postManButton("No", false, () {
                        Navigator.pop(context);
                      })),
                      const SizedBox(width: 10),
                      Expanded(
                        child: postManButton("Yes", true, () async {
                          await con
                              .updateOrderStatus(order.id!, "active")
                              .then((value) {
                            refresh();
                          });
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: order.status == "active",
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Text(
                    'Have you delivered the package to reciever?',
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                          child: postManButton("No", false, () {
                        Navigator.pop(context);
                      })),
                      const SizedBox(width: 10),
                      Expanded(
                        child: postManButton("Yes", true, () async {
                          await con
                              .updateOrderStatus(order.id!, "completed")
                              .then((value) {
                            refresh();
                          });
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget dimensions(context, package) => Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.06),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  "2.2 Kg",
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Weight",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Colors.grey),
                )
              ],
            ),
          ),
          Container(
            height: 30,
            width: 2,
            decoration: BoxDecoration(
                color: greenColor, borderRadius: BorderRadius.circular(radius)),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  "${package!.dimLength!.ceil()}' ${package!.dimWidth!.ceil()}' ${package!.dimHeight!.ceil()}'",
                  textScaleFactor: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  "Dimensions",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Colors.grey),
                )
              ],
            ),
          ),
          Container(
            height: 30,
            width: 2,
            decoration: BoxDecoration(
                color: greenColor, borderRadius: BorderRadius.circular(radius)),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  "\$${package!.value!.toStringAsFixed(2)}",
                  textScaleFactor: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  "Value",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Colors.grey),
                )
              ],
            ),
          ),
        ],
      ),
    );
