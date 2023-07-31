import 'package:flutter/material.dart';

import '../item_widget/item_community.dart';

class VolatilityPage extends StatefulWidget {
  const VolatilityPage({Key? key}) : super(key: key);

  @override
  State<VolatilityPage> createState() => _VolatilityPageState();
}

class _VolatilityPageState extends State<VolatilityPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return const itemCommunity();
        },
        itemCount: 4,
      ),
    );
  }
}
