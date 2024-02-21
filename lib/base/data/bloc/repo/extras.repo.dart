import 'package:postman_app/base/data/controllers/app.controller.dart';

import '../../models/faq.dart';
import '../../models/feed.dart';

final AppController con = AppController();

class ExtrasRepo {
  static Future<List<FAQ>> fetchFAQs() async {
    try {
      final faqs0 = await con.db
          .collection(con.faqsCol)
          .orderBy("createdAt", descending: true)
          .get();
      List<FAQ> faqs = faqs0.docs.map((e) => FAQ.fromMap(e.data())).toList();
      return faqs;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Feed>> fetchFeeds() async {
    try {
      final feeds0 = await con.db
          .collection(con.feedsCol)
          .orderBy("createdAt", descending: true)
          .get();
      List<Feed> feeds =
          feeds0.docs.map((e) => Feed.fromMap(e.data())).toList();
      return feeds;
    } catch (e) {
      throw Exception(e);
    }
  }
}
