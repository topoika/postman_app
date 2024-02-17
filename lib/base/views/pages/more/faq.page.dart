import 'package:flutter/material.dart';
import 'package:postman_app/base/data/helper/constants.dart';

import '../../../data/models/faq.dart';
import '../../components/universal.widgets.dart';

class FAQsPage extends StatefulWidget {
  const FAQsPage({super.key});

  @override
  State<FAQsPage> createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage> {
  int? active = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlackAppBar(
        title: const Text(
          "FAQs",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () => setState(() => faq.open = !faq.open),
                  splashColor: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          faq.title!,
                          textScaleFactor: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: greenColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: .9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          faq.open
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: Colors.black54,
                          size: 18,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: faq.open,
                  child: Text(
                    faq.description!,
                    textScaleFactor: 1,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<FAQ> faqs = [
    FAQ(
        title: 'What is Flutter?',
        description:
            'Flutter is an open-source UI software development kit created by Google. It is used to develop applications for mobile, web, and desktop from a single codebase.',
        open: true),
    FAQ(
      title: 'What are the advantages of using Flutter?',
      open: false,
      description:
          'Flutter offers fast development, expressive and flexible UI, native performance, and built-in testing capabilities.',
    ),
    FAQ(
      title: 'What platforms can I target with Flutter?',
      open: false,
      description:
          'Flutter allows you to build applications for mobile (iOS and Android), web, and desktop (Windows, MacOS, and Linux).',
    ),
    FAQ(
      title: 'What are the prerequisites for learning Flutter?',
      open: false,
      description:
          'To get started with Flutter, you need a basic understanding of programming concepts, preferably in a language such as Java, C#, or JavaScript. You also need to have a code editor (such as Visual Studio Code) and the Flutter SDK installed on your machine.',
    ),
    FAQ(
      title: 'How do I create a Flutter app?',
      open: false,
      description:
          'To create a new Flutter app, open your terminal or command prompt, navigate to the desired directory, and run the command `flutter create <app_name>`. Then, navigate to the app directory and run `flutter run` to launch the app on an emulator or physical device.',
    ),
    FAQ(
      title: 'Where can I find Flutter resources and documentation?',
      open: false,
      description:
          'You can find the official Flutter documentation, tutorials, and samples on the Flutter website (<https://flutter.dev/>). There are also many community-driven resources available, such as blogs, videos, and online courses.',
    ),
  ];
}
