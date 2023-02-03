import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/local/volatility_warning_stock.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/component/asset_chart.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/component/config_input.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/volatility_warning_catalog/logic/add_catalog_process.dart';
import 'package:flutter/material.dart';

import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';

import 'volatility_warning_catalog/sheet/volatility_warning_catalog_sheet.dart';

class VAVolatilityWarningScreen extends StatefulWidget {
  const VAVolatilityWarningScreen({super.key});

  @override
  State<VAVolatilityWarningScreen> createState() =>
      _VAVolatilityWarningScreenState();
}

class _VAVolatilityWarningScreenState extends State<VAVolatilityWarningScreen> {
  final IDataCenterService dataCenterService = DataCenterService();
  final IUserService userService = UserService();
  final ILocalStorageService localStorageService = LocalStorageService();
  late final SavedCatalog? savedCatalog;
  bool initialized = false;
  @override
  void initState() {
    super.initState();
    //init();
  }

  // void init() async {
  //   final result =
  //        localStorageService.getSavedCatalog(userService.token!.user);
  //   if (result == null || result.catalogs.isEmpty) {
  //     savedCatalog = SavedCatalog(userService.token!.user);
  //     await localStorageService.putSavedCatalog(savedCatalog!);
  //   } else {
  //     savedCatalog = result;
  //   }
  //   setState(() {
  //     initialized = true;
  //   });
  // }

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
              onTap: () => Navigator.of(context).pop(false),
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
          S.of(context).virtual_assistant,
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            S.of(context).volatility_warning,
            style:
                textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          Text(
            S.of(context).volatility_notice_quote1,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                S.of(context).account_notice,
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).net_assets,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "500,000,000đ",
                style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700, color: AppColors.primary_01),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: AssetChart(),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Expanded(
                child: ConfigInput(
                    label: "Ngưỡng báo động 1",
                    suffixType: SuffixType.percentage),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(
                child: ConfigInput(
                    label: "Ngưỡng báo động 2",
                    suffixType: SuffixType.percentage),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                S.of(context).catalog_notice,
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              )
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 100,
              child: InkWell(
                onTap: () {
                  AddCatalogISheet(savedCatalog!).show(
                      context,
                      VolatilityWarningCatalogSheet(
                          savedCatalog: savedCatalog!));
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Ink(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: const BoxDecoration(
                    color: AppColors.neutral_06,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox.square(
                            dimension: 24,
                            child: Image.asset(AppImages.additem_icon)),
                        Text(S.of(context).add_catalog)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
