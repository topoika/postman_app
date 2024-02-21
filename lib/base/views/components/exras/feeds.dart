// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/extras.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../../data/models/feed.dart';
import '../../pages/more/new.feeds.dart';
import '../buttons.dart';
import '../input/universal.widget.dart';
import '../universal.widgets.dart';

class FeedsList extends StatefulWidget {
  const FeedsList({
    Key? key,
    required this.feeds,
    required this.init,
  }) : super(key: key);
  final List<Feed> feeds;
  final Function init;
  @override
  State<FeedsList> createState() => _FeedsListState();
}

class _FeedsListState extends State<FeedsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.feeds.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        itemBuilder: (context, index) {
          final feed = widget.feeds[index];

          return Dismissible(
            key: ValueKey(feed.id),
            onDismissed: (DismissDirection direction) {
              if (isAdmin()) {}
              ExtraController().deleteFeed(feed).then((value) {
                widget.init();
              });
            },
            child: InkWell(
              onTap: () {
                if (isAdmin()) {
                  showFeedInputForm(context, feed, () => widget.init());
                }
              },
              splashColor: Colors.grey.withOpacity(.2),
              child: Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            feed.createBy!.image != null
                                ? showLargeImage(
                                    context, feed.createBy!.image, null)
                                : toastShow(
                                    context, "No profile picture", "nor");
                          },
                          child: Container(
                            height: getWidth(context, 10),
                            width: getWidth(context, 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.3),
                              image: feed.createBy!.image != null
                                  ? DecorationImage(
                                      image: cachedImage(
                                          feed.createBy!.image ?? noUserImage),
                                      fit: BoxFit.fill,
                                    )
                                  : null,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 2, color: greenColor.withOpacity(.5)),
                            ),
                            child: feed.createBy!.image == null
                                ? const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: 30,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              feed.createBy!.username ?? "",
                              textScaleFactor: 1,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              getTimeAgo(DateTime.parse(feed.createdAt!)),
                              textScaleFactor: 1,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black45,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      feed.title ?? "",
                      textScaleFactor: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      feed.description ?? "",
                      textScaleFactor: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class FeedInputForm extends StatefulWidget {
  final Feed feed;
  final Function onSubmit;
  const FeedInputForm({super.key, required this.feed, required this.onSubmit});

  @override
  _FeedInputFormState createState() => _FeedInputFormState();
}

class _FeedInputFormState extends StateMVC<FeedInputForm> {
  late ExtraController con;
  _FeedInputFormState() : super(ExtraController()) {
    con = controller as ExtraController;
  }
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    bool edit = widget.feed.id != null;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: con.formKey,
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          shrinkWrap: true,
          children: <Widget>[
            mainHeading(context, edit ? "Edit Feed" : "Add new Feed"),
            const SizedBox(height: 20),
            InputFieldItem(
              hint: "Title",
              label: "Feed Title",
              onValidate: (val) => con.setError(val),
              type: "text",
              onsaved: (val) => widget.feed.title = val,
              init: widget.feed.title,
            ),
            InputFieldItem(
              hint: "Description",
              label: "Feed Body",
              onValidate: (val) => con.setError(val),
              type: "description",
              onsaved: (val) => widget.feed.description = val,
              init: widget.feed.description,
            ),
            Visibility(
                visible: loading,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
            Visibility(
              visible: !loading,
              child: buttonOne(edit ? "Update Feed" : "Submit Feed", true,
                  () async {
                if (con.formKey.currentState!.validate()) {
                  setState(() => loading = true);
                  con.formKey.currentState!.save();
                  if (edit) {
                    await con.updateFeed(widget.feed);
                  } else {
                    await con.addFeed(widget.feed);
                  }
                  setState(() => loading = false);
                  Navigator.pop(context);
                  widget.onSubmit();
                } else {
                  con.error != null
                      ? toastShow(context, con.error.toString(), "err")
                      : null;
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
