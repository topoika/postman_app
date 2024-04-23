import 'package:flutter/material.dart';

import '../bloc/events/request.events.dart';
import '../bloc/providers/request.provier.dart';
import '../helper/helper.dart';
import 'app.controller.dart';

class OrderController extends AppController {
  RequestsBloc orderBloc = RequestsBloc();
  RequestsBloc ordersBloc = RequestsBloc();
  void initOrders(id) {
    ordersBloc.add(FetTripOrders(id));
  }

  Future updateOrderStatus(String id, String status) async {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    try {
      await db.collection(orderCol).doc(id).update({"status": status});
      loader.remove();
      toastShow(
          scaffoldKey.currentContext!, "Order updated successfully", 'suc');
    } catch (e) {
      loader.remove();
      toastShow(
          scaffoldKey.currentContext!, "There was an error, try again", 'err');
      print(e);
    }
  }
}
