import 'package:cloud_firestore/cloud_firestore.dart';

import '../../controllers/app.controller.dart';
import '../../models/request.dart';

class RequestsRepo {
  // get all the user order requests
  static Future<List<Request>> fetchMyRequests() async {
    try {
      CollectionReference requestCol =
          FirebaseFirestore.instance.collection('requests');
      QuerySnapshot querySnapshot = await requestCol
          .where("recieverId", isEqualTo: activeUser.value.id)
          .where("status", isEqualTo: "active")
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
