import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:flutter/material.dart';

class ConditionalOrderTab extends StatelessWidget {
  const ConditionalOrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: const Center(child: EmptyListWidget()),
          )
        ],
      ),
    );
  }
}
