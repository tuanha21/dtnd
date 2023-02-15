import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class RoundedTabbar extends StatelessWidget {
  const RoundedTabbar({
    super.key,
    required this.controller,
    required this.tabs,
    this.isScrollable = true,
  });
  final TabController controller;
  final List<Widget> tabs;
  final bool isScrollable;
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final tabbarBgColor =
        themeMode.isLight ? AppColors.neutral_05 : AppColors.neutral_01;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: tabbarBgColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: TabBar(
        controller: controller,
        isScrollable: isScrollable,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: AppColors.primary_01,
        ),
        labelColor: AppColors.neutral_07,
        unselectedLabelColor:
            themeMode.isLight ? AppColors.neutral_01 : AppColors.neutral_07,
        labelPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        padding: EdgeInsets.zero,
        // indicatorSize: TabBarIndicatorSize.label,
        tabs: tabs,
      ),
    );
  }
}
