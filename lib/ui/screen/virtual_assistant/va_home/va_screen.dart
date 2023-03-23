import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_access_element.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/virtual_assistant_filter_screen.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/va_volatolity_warning_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widget/my_appbar.dart';
import 'auto_trade/auto_trade.dart';
import 'my_directory/my_directory.dart';

enum VAFeature {
  stockFilter,
  volatilityWarning,
}

extension VirtualAssistantFeatureX on VAFeature {
  String get name {
    switch (this) {
      case VAFeature.stockFilter:
        return S.current.filter_stock;
      case VAFeature.volatilityWarning:
        return "Lọc tín hiệu";
    }
  }

  VoidCallback onPressed(BuildContext context) {
    switch (this) {
      case VAFeature.stockFilter:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AssistantStockFilterScreen(),
            ));
      case VAFeature.volatilityWarning:
        return () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const VAVolatilityWarningScreen(),
              ),
            );
    }
  }
}

class VaScreen extends StatefulWidget {
  const VaScreen({super.key});

  @override
  State<VaScreen> createState() => _VaScreenState();
}

class _VaScreenState extends State<VaScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    // final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: MyAppBar(
        leading: Align(
          alignment: Alignment.centerRight,
          child: SizedBox.square(
            dimension: 32,
            child: InkWell(
              onTap: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: Ink(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: themeMode.isLight
                      ? AppColors.neutral_05
                      : AppColors.neutral_01,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.primary_01,
                  size: 10,
                ),
              ),
            ),
          ),
        ),
        title: S.of(context).DTND_assistant,
        actions: [
          GestureDetector(
            onTap: () {
              // cái này là khi click vào cái chấm ba chấm ...
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset(AppImages.icon_dot),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Align(
              alignment: Alignment.center,
              child: TabBar(
                controller: _tabController,
                isScrollable: false,
                padding: EdgeInsets.zero,
                tabs: List.generate(
                  VaAccess.values.length,
                  (index) => VaAccessElement(
                    value: VaAccess.values.elementAt(index),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [MyDirectoryTab(), AutoTradeTab()],
            ),
          ),
        ],
      ),
    );
  }
}
