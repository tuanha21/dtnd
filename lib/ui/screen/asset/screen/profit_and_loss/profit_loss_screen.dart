import 'dart:ui';

import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/chart/circle_process_chart.dart';
import 'package:dtnd/ui/widget/section/simple_appbar.dart';
import 'package:flutter/material.dart';

class ProfitLossScreen extends StatefulWidget {
  const ProfitLossScreen({super.key});

  @override
  State<ProfitLossScreen> createState() => _ProfitLossScreenState();
}

class _ProfitLossScreenState extends State<ProfitLossScreen>
    with SingleTickerProviderStateMixin {
  final IDataCenterService dataCenterService = DataCenterService();

  late final TabController tabController;
  int currentTab = 0;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  void changeTab(int key) {
    if (tabController.index == key) {
      return;
    }
    tabController.animateTo(key);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Widget body = RefreshIndicator(
      onRefresh: () async {},
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox.square(
                    dimension: 120,
                    child: CircleProcessChart(
                      onTap: () => changeTab(0),
                      percent: 65,
                      arcWidth: 6,
                      color: AppColors.graph_3,
                      bottomChild: Text(
                        mapData.keys.toList().elementAt(0),
                        style: textTheme.bodyMedium,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Text(
                          "200Tr",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox.square(
                    dimension: 120,
                    child: Expanded(
                      child: CircleProcessChart(
                        onTap: () => changeTab(1),
                        percent: 10,
                        arcWidth: 6,
                        color: AppColors.graph_2,
                        bottomChild: Text(
                          mapData.keys.toList().elementAt(1),
                          style: textTheme.bodyMedium,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Text(
                            "23Tr",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox.square(
                    dimension: 120,
                    child: CircleProcessChart(
                      onTap: () => changeTab(2),
                      percent: 15,
                      arcWidth: 6,
                      color: AppColors.graph_4,
                      bottomChild: Text(
                        mapData.keys.toList().elementAt(2),
                        style: textTheme.bodyMedium,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Text(
                          "13Tr",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  _Panel(
                    data: mapData.values.toList().elementAt(0),
                  ),
                  _Panel(
                    data: mapData.values.toList().elementAt(1),
                  ),
                  _Panel(
                    data: mapData.values.toList().elementAt(2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).profit_and_loss,
      ),
      body: body,
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Map<String, String> data;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white),
            child: Column(
              children: [
                for (int i = 0; i < data.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.keys.toList().elementAt(i),
                          style: textTheme.labelMedium!
                              .copyWith(color: AppColors.neutral_03),
                        ),
                        Text(
                          data.values.toList().elementAt(i),
                          style: textTheme.labelMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

final Map<String, Map<String, String>> mapData = {
  "Cổ phiếu": {
    "GT DMCK sở hữu": "10.000.000 đ",
    "Giá trị CP mua chờ về": "10.000.000 đ",
    "Giá trị CP bán chờ thanh toán": "10.000.000 đ",
    "Giá trị quyền chờ về": "10.000.000 đ",
    "Cổ tức bằng tiền mặt": "10.000.000 đ",
    "Cổ tức bằng CP": "10.000.000 đ",
    "Quyền mua": "10.000.000 đ",
  },
  "Chứng quyền": {
    "Giá trị CW đang có": "10.000.000 đ",
    "Giá trị CW mua chờ về": "10.000.000 đ",
    "Giá trị CW bán chờ thanh toán": "10.000.000 đ",
  },
  "ETF": {
    "GT DMCK sở hữu": "10.000.000 đ",
    "Giá trị CP mua chờ về": "10.000.000 đ",
    "Giá trị CP bán chờ thanh toán": "10.000.000 đ",
    "Giá trị quyền chờ về": "10.000.000 đ",
    "Cổ tức bằng tiền mặt": "10.000.000 đ",
    "Cổ tức bằng CP": "10.000.000 đ",
    "Quyền mua": "10.000.000 đ",
  },
};
