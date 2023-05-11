import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:flutter/material.dart';

class AccumulatorHistory extends StatefulWidget {
  const AccumulatorHistory({super.key});

  @override
  State<AccumulatorHistory> createState() => _AccumulatorHistoryState();
}

class _AccumulatorHistoryState extends State<AccumulatorHistory> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [EmptyListWidget()]);
  }
}
