import 'package:cloud_firestore/cloud_firestore.dart' hide Order;

import '../../controllers/app.controller.dart';
import '../../models/order.dart';
import '../../models/request.dart';

class RequestsRepo extends AppController {
  // get all the user order requests
  Future<List<Request>> fetchMyRequests() async {
    try {
      CollectionReference requestCol = db.collection('requests');
      QuerySnapshot querySnapshot = await requestCol
          .where("recieverId", isEqualTo: activeUser.value.id)
          .where("status", isEqualTo: "pending")
          .orderBy("createdAt", descending: true)
          .get()
          .onError((error, stackTrace) =>
              throw Exception('Failed to load requests'));
      // Convert documents to Package objects
      List<Request> requests = querySnapshot.docs
          .map((doc) => Request.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return requests;
    } catch (e) {
      throw Exception(e);
    }
  }

  // get all the triep order requests
  Future<List<Order>> fetchTripOrders(String id) async {
    try {
      final data = await db
          .collection(orderCol)
          .where("tripId", isEqualTo: id)
          .orderBy("createdAt", descending: true)
          .get()
          .onError((error, stackTrace) =>
              throw Exception('Failed to load requests'));
      // Convert documents to Package objects
      List<Order> orders =
          data.docs.map((doc) => Order.fromMap(doc.data())).toList();
      return orders;
    } catch (e) {
      throw Exception(e);
    }
  }

  // get all the triep order requests
  Future<Order> fetchOrderDetails(String id) async {
    try {
      final data = await db.collection(orderCol).doc(id).get().onError(
          (error, stackTrace) =>
              throw Exception('Failed to load Ordder details'));
      return Order.fromMap(data.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception(e);
    }
  }

  // get all the user order requests
  static Future<List<Request>> fetchPackageRequests(String id) async {
    try {
      CollectionReference requestCol =
          FirebaseFirestore.instance.collection('requests');
      QuerySnapshot querySnapshot = await requestCol
          .where("senderId", isEqualTo: activeUser.value.id)
          .where("packageId", isEqualTo: id)
          .orderBy("createdAt", descending: true)
          .get()
          .onError((error, stackTrace) =>
              throw Exception('Failed to load requests'));
      // Convert documents to Package objects
      List<Request> requests = querySnapshot.docs
          .map((doc) => Request.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return requests;
    } catch (e) {
      throw Exception(e);
    }
  }
}
