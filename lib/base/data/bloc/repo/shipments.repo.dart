import 'package:cloud_firestore/cloud_firestore.dart' hide Order;

import '../../controllers/app.controller.dart';
import '../../models/order.dart';

class ShipmentsRepo {
  // fetch all the shipments
  static Future<List<Order>> fetchMyShipments() async {
    try {
      CollectionReference shipmentCol =
          FirebaseFirestore.instance.collection('orders');
      QuerySnapshot querySnapshot = await shipmentCol
          .where("senderId", isEqualTo: activeUser.value.id)
          .orderBy("createdAt", descending: true)
          .get()
          .onError(
              (error, stackTrace) => throw Exception('Failed to load trips'));
      // Convert documents to Trip objects
      List<Order> shipments = querySnapshot.docs
          .map((doc) => Order.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return shipments;
    } catch (e) {
      throw Exception(e);
    }
  }
}
