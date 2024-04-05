import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:postman_app/base/data/controllers/app.controller.dart';

import '../../models/package.dart';

class PackagesRepo {
  // fetch all the packages
  static Future<List<Package>> fetchPackages() async {
    try {
      CollectionReference tripsColl =
          FirebaseFirestore.instance.collection('packages');
      QuerySnapshot querySnapshot = await tripsColl
          .where("senderId", isNotEqualTo: activeUser.value.id)
          .where("ordered", isEqualTo: false)
          .get()
          .onError(
              (error, stackTrace) => throw Exception('Failed to load trips'));
      // Convert documents to Package objects
      List<Package> packages = querySnapshot.docs
          .map((doc) => Package.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return packages;
    } catch (e) {
      throw Exception(e);
    }
  }

  // fetch all my packages
  static Future<List<Package>> fetchMyPackages() async {
    try {
      CollectionReference tripsColl =
          FirebaseFirestore.instance.collection('packages');
      QuerySnapshot querySnapshot = await tripsColl
          .where("senderId", isEqualTo: activeUser.value.id)
          .where("ordered", isEqualTo: false)
          .orderBy("createAt", descending: true)
          .get()
          .onError(
              (error, stackTrace) => throw Exception('Failed to load trips'));
      // Convert documents to Package objects
      List<Package> packages = querySnapshot.docs
          .map((doc) => Package.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return packages;
    } catch (e) {
      throw Exception(e);
    }
  }
}
