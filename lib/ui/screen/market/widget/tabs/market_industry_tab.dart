import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/market/widget/components/heap_map_widget.dart';
import 'package:flutter/material.dart';

class MarketIndustryTab extends StatefulWidget {
  const MarketIndustryTab({super.key});

  @override
  State<MarketIndustryTab> createState() => _MarketIndustryTabState();
}

class _MarketIndustryTabState extends State<MarketIndustryTab> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleTextStyle =
        textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).industry_list,
                style: titleTextStyle,
              )
            ],
          ),
          const SizedBox(height: 10),
          const Expanded(child: HeapMapWidget()),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}
