// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:postman_app/base/data/helper/constants.dart';

import '../../components/universal.widgets.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlackAppBar(
        title: const Text(
          "More",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        cancel: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: moreItems.map((e) {
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, e.link!),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: greenColor.withOpacity(.09),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/icons/${e.icon}",
                      color: greenColor,
                      height: 24,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.txt!,
                              textScaleFactor: 1,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Container(
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
                        const SizedBox(height: 13),
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
}

class MoreItem {
  String? icon;
  String? txt;
  String? link;
  MoreItem({
    this.icon,
    this.txt,
    this.link,
  });
}

List<MoreItem> moreItems = [
  MoreItem(
      txt: "Order Requests", icon: "orders.png", link: "/OrderRequestPage"),
  MoreItem(
      txt: "Active Packages", icon: "my_packages.png", link: "/MyPackagesPage"),
  MoreItem(txt: "Payment Method", icon: "payment.png", link: "/PaymentMethods"),
  MoreItem(
      txt: "Frequently asked questions", icon: "faq.png", link: "/FAQsPage"),
  MoreItem(txt: "Help & Support", icon: "help.png", link: "/HelpAndSupport"),
  MoreItem(
      txt: "About - Legal & Policy",
      icon: "about.png",
      link: "/HelpAndSupport"),
];
