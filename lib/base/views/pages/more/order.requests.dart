import 'package:flutter/material.dart';

import '../../components/universal.widgets.dart';

class OrderRequestPage extends StatefulWidget {
  const OrderRequestPage({super.key});

  @override
  State<OrderRequestPage> createState() => _OrderRequestPageState();
}

class _OrderRequestPageState extends State<OrderRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlackAppBar(
        title: const Text(
          "Order Requests",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(),
    );
  }
}
