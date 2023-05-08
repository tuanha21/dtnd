import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/widget/accumulator_book.dart';
import 'package:dtnd/ui/screen/accumulation/widget/accumulator_header.dart';
import 'package:dtnd/ui/screen/accumulation/widget/accumulator_history.dart';
import 'package:dtnd/ui/screen/accumulation/widget/accumulator_product.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';

class Accumlation extends StatefulWidget {
  const Accumlation({super.key, this.defaultab = 0});
  final int defaultab;

  @override
  State<Accumlation> createState() => _AccumlationState();
}

class _AccumlationState extends State<Accumlation>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      tabController.animateTo(widget.defaultab);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).accumulation,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
        child: Column(
          children: [
            const AccumulatorHeader(),
            const SizedBox(height: 10),
            TabBar(
              controller: tabController,
              isScrollable: false,
              labelStyle: textTheme.titleSmall,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              tabs: const [
                Text(
                  'Sản phẩm',
                ),
                Text(
                  'Sổ tích luỹ',
                ),
                Text(
                  'Lịch sử',
                ),
              ],
            ),
            Expanded(
                child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const [
                AccumulatorProduct(),
                AccumulatorBook(),
                AccumulatorHistory()
              ],
            ))
          ],
        ),
      ),
    );
  }
}
