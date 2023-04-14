import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/tab/inday_order_tab.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/tab/order_history_tab.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_image.dart';

class OrderNoteScreen extends StatefulWidget {
  const OrderNoteScreen({super.key, this.defaultab = 0});
  final int defaultab;
  @override
  State<OrderNoteScreen> createState() => _OrderNoteScreenState();
}

class _OrderNoteScreenState extends State<OrderNoteScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      tabController.animateTo(widget.defaultab);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar:
      SimpleAppbar(
        title: S.of(context).base_note,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                AppImages.setting_2,
                width: 24,
                height: 24,
              ))
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            isScrollable: false,
            labelStyle: textTheme.titleSmall,
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            tabs: [
              Text(
                S.of(context).inday_note,
              ),
              Text(
                S.of(context).order_history,
              ),
            ],
          ),
          Expanded(
              child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: const [
              IndayOrderTab(),
              OrderHistoryTab(),
            ],
          ))
        ],
      ),
    );
  }
}
