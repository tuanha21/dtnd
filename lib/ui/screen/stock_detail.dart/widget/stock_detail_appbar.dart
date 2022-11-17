import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockDetailAppbar extends StatefulWidget implements PreferredSizeWidget {
  const StockDetailAppbar({Key? key}) : super(key: key);

  @override
  State<StockDetailAppbar> createState() => _StockDetailAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _StockDetailAppbarState extends State<StockDetailAppbar> {
  final AppService appService = AppService();
  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<ThemeMode>>((themeMode) {
      return AppBar(
        leading: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Ink(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: themeMode.value.isLight
                      ? AppColors.neutral_05
                      : AppColors.neutral_01),
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.primary_01,
                size: 10,
              ),
            ),
          ),
        ),
      );
    }, appService.themeMode);
  }
}
