import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../item_widget/item_notification.dart';

class AllPage extends StatefulWidget {
  const AllPage({Key? key}) : super(key: key);

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return itemNotification();
        },
        itemCount: 3,
      ),
    );
  }
}
