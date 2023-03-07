import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/virtual_assistant_filter_screen.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/va_volatolity_warning_screen.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_register/va_register.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

enum VAFeature {
  stockFilter,
  volatilityWarning,
  volatilityRegister,
}

extension VirtualAssistantFeatureX on VAFeature {
  String get name {
    switch (this) {
      case VAFeature.stockFilter:
        return S.current.filter_stock;
      case VAFeature.volatilityWarning:
        return "Lọc tín hiệu";
      case VAFeature.volatilityRegister:
        return "Giao dịch tự động";
    }
  }

  String get iconPath {
    switch (this) {
      case VAFeature.stockFilter:
        return AppImages.chart2_icon;
      case VAFeature.volatilityWarning:
        return AppImages.directbox_receive_icon;
      case VAFeature.volatilityRegister:
        return AppImages.directbox_receive_icon;
    }
  }

  VoidCallback onPressed(BuildContext context) {
    switch (this) {
      case VAFeature.stockFilter:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AssistantStockFilterScreen(),
            ));
      case VAFeature.volatilityWarning:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const VAVolatilityWarningScreen(),
            ));
      case VAFeature.volatilityRegister:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const VARegister(),
            ));
    }
  }
}

class VAScreen extends StatefulWidget {
  const VAScreen({super.key});

  @override
  State<VAScreen> createState() => _VAScreenState();
}

class _VAScreenState extends State<VAScreen> {
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.centerRight,
          child: SizedBox.square(
            dimension: 32,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
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
        title: Text(
          S.of(context).DTND_assistant,
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: VAFeature.values.length,
        // shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: VAFeature.values[index].onPressed(context),
            leading: SizedBox.square(
              dimension: 24,
              child: Image.asset(VAFeature.values[index].iconPath),
            ),
            title: Text(VAFeature.values[index].name),
            trailing: const Icon(Icons.chevron_right_outlined),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 8,
        ),
      ),
    );
  }
}
