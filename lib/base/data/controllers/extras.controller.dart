import '../../../main.dart';
import '../helper/helper.dart';
import '../models/faq.dart';
import '../models/feed.dart';
import 'app.controller.dart';

class ExtraController extends AppController {
  String? error;

  setError(val) => setState(() => error = val);

  // add FAQ
  Future<void> addFaq(FAQ faq) async {
    try {
      faq.createBy = activeUser.value.username;
      faq.createdAt = DateTime.now().toString();
      faq.open = false;
      await db.collection(faqsCol).add(faq.toMap()).then((value) {
        value.update({"id": value.id});
      });
    } catch (e) {
      toastShow(Get.context!, "An error occurred, please try again", 'err');
    }
  }

  // Update faq
  Future<void> updateFaq(FAQ faq) async {
    try {
      await db
          .collection(faqsCol)
          .doc(faq.id!)
          .update(faq.toMap())
          .then((value) {});
    } catch (e) {
      toastShow(Get.context!, "An error occurred, please try again", 'err');
    }
  }

  // delete faq
  Future<void> deleteFaq(FAQ faq) async {
    // delete faq
    try {
      await db.collection(faqsCol).doc(faq.id!).delete().then((value) {});
    } catch (e) {
      toastShow(Get.context!, "An error occurred, please try again", 'err');
    }
  }

  // add FEED
  Future<void> addFeed(Feed feed) async {
    try {
      feed.createBy = activeUser.value;
      feed.createdAt = DateTime.now().toString();
      await db.collection(feedsCol).add(feed.toMap()).then((value) {
        value.update({"id": value.id});
      });
    } catch (e) {
      toastShow(Get.context!, "An error occurred, please try again", 'err');
    }
  }

  // Update feed
  Future<void> updateFeed(Feed feed) async {
    try {
      await db
          .collection(feedsCol)
          .doc(feed.id!)
          .update(feed.toMap())
          .then((value) {});
    } catch (e) {
      toastShow(Get.context!, "An error occurred, please try again", 'err');
    }
  }

  // delete feed
  Future<void> deleteFeed(Feed feed) async {
    // delete faq
    try {
      await db.collection(feedsCol).doc(feed.id!).delete().then((value) {});
    } catch (e) {
      toastShow(Get.context!, "An error occurred, please try again", 'err');
    }
  }
}
