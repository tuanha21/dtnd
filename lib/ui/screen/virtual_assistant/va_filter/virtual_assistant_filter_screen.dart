import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/bottom_sheet/add_filter_stock.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/bottom_sheet/filter_stocks.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/bottom_sheet/filter_stocks_figure.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/virtual_assistant_filter_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'component/following_stock_component.dart';
import 'logic/bottom_sheet_cmd.dart';

class AssistantStockFilterScreen extends StatefulWidget {
  const AssistantStockFilterScreen({super.key});

  @override
  State<AssistantStockFilterScreen> createState() =>
      _AssistantStockFilterScreenState();
}

class _AssistantStockFilterScreenState
    extends State<AssistantStockFilterScreen> {
  final VirtualAssistantFilterController controller =
      VirtualAssistantFilterController();
  final IDataCenterService dataCenterService = DataCenterService();

  bool initialized = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (!controller.initialized.value) {
      await controller.init();
    }
    setState(() {
      initialized = true;
    });
  }

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
            S.of(context).stocks_you_interested,
            style:
                textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          Text(
            S.of(context).choose_stocks_you_interested,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).stocks_you_interested,
                style:
                    textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              Material(
                child: InkWell(
                  onTap: onAddingStock,
                  child: Ink(
                    child: Text(
                      S.of(context).add_stock,
                      style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary_01),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Builder(
            builder: (context) {
              if (!initialized) {
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: Text(S.of(context).loading),
                  ),
                );
              }
              if (controller.followingCatalog.isEmpty) {
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(
                          AppImages.empty_holder,
                          scale: 2,
                        ),
                        Text(S.of(context).empty_catalog),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: List<Widget>.generate(
                  controller.followingCatalog.length,
                  (index) => FollowingStockComponent(
                    index: index,
                    model: controller.followingCatalog[index],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> onAddingStock() async {
    final cmd = await ModelBottomSheet.showBottomSheet<BottomSheetCmd>(
      context: context,
      children: const [AddFilterStock()],
    );
    if (cmd != BottomSheetCmd.toFilter) {
      return;
    }
    final toFilterCmd = await toFilter();

    if (toFilterCmd == BottomSheetCmd.back) {
      return onAddingStock();
    } else {
      return;
    }
  }

  Future<BottomSheetCmd?> toFilter() async {
    final toFilterCmd = await ModelBottomSheet.showBottomSheet(
      context: context,
      isScrollControlled: true,
      children: const [FilterStocks()],
    );
    if (toFilterCmd == null) {
      return null;
    } else if (toFilterCmd is BottomSheetCmd) {
      return BottomSheetCmd.back;
    } else {
      final toFilterFigureCmd = await ModelBottomSheet.showBottomSheet(
        context: context,
        isScrollControlled: true,
        children: [
          FilterStocksFigure(
            listCriterionFigure: toFilterCmd,
          )
        ],
      );
      if (toFilterFigureCmd is BottomSheetCmd) {
        if (toFilterFigureCmd == BottomSheetCmd.back) {
          return toFilter();
        } else {
          return BottomSheetCmd.done;
        }
      } else {
        return BottomSheetCmd.done;
      }
    }
  }
}
