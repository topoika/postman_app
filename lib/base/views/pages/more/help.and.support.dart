import 'package:flutter/material.dart';

import '../../../data/helper/constants.dart';
import '../../components/universal.widgets.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({super.key});

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlackAppBar(
        title: const Text(
          "Help & Support",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        cancel: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: items.map((e) {
          return GestureDetector(
            // onTap: () => Navigator.pushNamed(context, e.link!),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      "assets/icons/${e['icon']}",
                      color: greenColor,
                      height: 24,
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e['name'],
                              textScaleFactor: 1,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: .4, color: Colors.grey)),
                              child: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black45,
                                size: 13,
                              ),
                            )
                          ],
                        ),
                        Text(
                          e['desc'],
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        const SizedBox(height: 6),
                        const Divider(
                          color: Colors.black12,
                          thickness: .6,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  List items = [
    {
      "name": "Help Center",
      "icon": "center.png",
      "desc": "Fast answers to all of the most common questions.",
      "link": ""
    },
    {
      "name": "Contact Support",
      "icon": "cantact_support.png",
      "desc": "Chat with our team of experts",
      "link": ""
    },
    {
      "name": "Call Center",
      "icon": "call_center.png",
      "desc": "Call us to speak to a support agent",
      "link": ""
    },
  ];
}
