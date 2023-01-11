import 'dart:ui';

import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/component/asset_per_type_widget.dart';
import 'package:dtnd/ui/screen/asset/component/total_asset_widget.dart';
import 'package:dtnd/ui/screen/asset/logic/investment_catalog.dart';
import 'package:dtnd/ui/screen/asset/logic/money_type.dart';
import 'package:dtnd/ui/screen/asset/screen/base_note/tab/inday_order_tab.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/component/asset_chart.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
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

  final defaultCatalog = <String>[
    "ACB",
    "FPT",
    "VCB",
    "GAS",
    "TPB",
  ];

  final List<InvestmentCatalog> list = [];

  bool gettingCatalog = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    Widget body = RefreshIndicator(
      onRefresh: () async {},
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: ListView(
          children: [
            Row(
              children: const [
                Expanded(
                  child: SizedBox.square(
                    dimension: 100,
                    child: CircleProcessChart(
                      percent: 65,
                      arcWidth: 6,
                      color: AppColors.graph_3,
                      child: Padding(
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
                    dimension: 100,
                    child: CircleProcessChart(
                      percent: 10,
                      arcWidth: 6,
                      color: AppColors.graph_2,
                      child: Padding(
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
                Expanded(
                  child: SizedBox.square(
                    dimension: 100,
                    child: CircleProcessChart(
                      percent: 15,
                      arcWidth: 6,
                      color: AppColors.graph_4,
                      child: Padding(
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 100),
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
