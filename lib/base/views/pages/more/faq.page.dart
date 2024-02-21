import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/bloc/events/extras.events.dart';
import '../../../data/bloc/providers/extras.provider.dart';
import '../../../data/bloc/state/extras.state.dart';
import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/extras.controller.dart';
import '../../../data/models/faq.dart';
import '../../components/exras/faqs.dart';
import '../../components/universal.widgets.dart';

class FAQsPage extends StatefulWidget {
  const FAQsPage({super.key});

  @override
  _FAQsPageState createState() => _FAQsPageState();
}

class _FAQsPageState extends StateMVC<FAQsPage> {
  late ExtraController con;
  _FAQsPageState() : super(ExtraController()) {
    con = controller as ExtraController;
  }

  ExtrasBloc faqsBloc = ExtrasBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    faqsBloc.add(FetchFAQsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlackAppBar(
        title: const Text(
          "FAQs",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          Visibility(
            visible: isAdmin(),
            child: InkWell(
              onTap: () {
                showFaqInputForm(context, FAQ(), () => init());
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
                  case FAQsLoadingState:
                    return const Center(child: CircularProgressIndicator());
                  case FAQsErrorState:
                    final error = state as FAQsErrorState;
                    return emptyWidget(context, error.message);
                  case FAQsLoadedState:
                    final suc = state as FAQsLoadedState;
                    return suc.faqs.isEmpty
                        ? emptyWidget(
                            context, "There are no FAQs at the moment")
                        : FAQsList(faqs: suc.faqs, init: () => init());

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

void showFaqInputForm(context, FAQ faq, init) {
  showDialog(
    context: context,
    barrierColor: Colors.black26,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: FAQInputForm(
          faq: faq,
          onSubmit: () => init(),
        ),
      );
    },
  );
}
