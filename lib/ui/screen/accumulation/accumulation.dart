import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/controller/accumulation_controller.dart';
import 'package:dtnd/ui/screen/accumulation/widget/accumulator_book.dart';
import 'package:dtnd/ui/screen/accumulation/widget/accumulator_header.dart';
import 'package:dtnd/ui/screen/accumulation/widget/accumulator_history.dart';
import 'package:dtnd/ui/screen/accumulation/widget/accumulator_product.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';

import '../../../config/service/app_services.dart';

class Accumlation extends StatefulWidget {
  const Accumlation({super.key, this.defaultab = 0});

  final int defaultab;

  @override
  State<Accumlation> createState() => _AccumlationState();
}

class _AccumlationState extends State<Accumlation>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final AccumulationController controller = AccumulationController();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
    controller.init();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      tabController.animateTo(widget.defaultab);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final themeMode = AppService.instance.themeMode.value;

    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).accumulation,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
        child: Column(
          children: [
            AccumulatorHeader(),
            const SizedBox(height: 10),
            TabBar(
              controller: tabController,
              isScrollable: false,
              labelStyle: textTheme.titleSmall,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              tabs: [
                Text(
                  S.of(context).product,
                ),
                Text(
                  S.of(context).accumulator_book,
                ),
                Text(
                  S.of(context).history,
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
