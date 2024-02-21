import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/bloc/events/extras.events.dart';
import '../../../data/bloc/providers/extras.provider.dart';
import '../../../data/bloc/state/extras.state.dart';
import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/extras.controller.dart';
import '../../../data/models/feed.dart';
import '../../components/exras/feeds.dart';
import '../../components/universal.widgets.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends StateMVC<NewsFeedPage> {
  late ExtraController con;
  _NewsFeedPageState() : super(ExtraController()) {
    con = controller as ExtraController;
  }

  ExtrasBloc faqsBloc = ExtrasBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    faqsBloc.add(FetchFeeds());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlackAppBar(
        title: const Text(
          "News Feed",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          Visibility(
            visible: isAdmin(),
            child: InkWell(
              onTap: () {
                showFeedInputForm(context, Feed(), () => init());
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          init();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          shrinkWrap: true,
          children: [
            BlocConsumer<ExtrasBloc, ExtrasState>(
              bloc: faqsBloc,
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.runtimeType) {
                  case FeedsLoadingState:
                    return const Center(child: CircularProgressIndicator());
                  case FeedsErrorState:
                    final error = state as FeedsErrorState;
                    return emptyWidget(context, error.message);
                  case FeedsLoadedState:
                    final suc = state as FeedsLoadedState;
                    return suc.feeds.isEmpty
                        ? emptyWidget(
                            context, "There are no Feeds at the moment")
                        : FeedsList(feeds: suc.feeds, init: () => init());

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

void showFeedInputForm(context, Feed feed, init) {
  showDialog(
    context: context,
    barrierColor: Colors.black26,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: FeedInputForm(
          feed: feed,
          onSubmit: () => init(),
        ),
      );
    },
  );
}
