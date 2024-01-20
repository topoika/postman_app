import 'package:flutter/material.dart';

import '../components/universal.widgets.dart';

class NewOrderPage extends StatefulWidget {
  final String? id;
  const NewOrderPage({super.key, required this.id});

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "New Order"),
      body: Container(),
    );
  }
}
