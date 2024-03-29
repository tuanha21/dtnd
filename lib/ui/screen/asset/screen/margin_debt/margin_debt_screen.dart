import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../../=models=/response/market/stock_model.dart';
import '../../../../../config/service/app_services.dart';
import '../../../../../utilities/num_utils.dart';
import '../../../../../utilities/time_utils.dart';
import '../../../../theme/app_image.dart';
import '../../../../theme/app_textstyle.dart';
import '../../../../widget/calendar/day_input.dart';
import '../../../exchange_stock/stock_order/business/stock_order_flow.dart';
import '../../../exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import 'item_margin_debt_widget.dart';
import 'margin_debt_controller.dart';

class MarginDebtScreen extends StatefulWidget {
  const MarginDebtScreen({Key? key}) : super(key: key);

  @override
  State<MarginDebtScreen> createState() => _MarginDebtScreenState();
}

class _MarginDebtScreenState extends State<MarginDebtScreen> {
  final MarginDebtControllers controller = MarginDebtControllers();

  late DateTime fromDay;
  late DateTime toDay;
  late DateTime firstDay;
  late DateTime lastDay;

  @override
  void initState() {
    fromDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(1));
    toDay = DateTime.now();
    firstDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(3));
    lastDay = toDay;
    super.initState();
    EasyLoading.show();
    controller.getDebt();
    EasyLoading.dismiss();
  }

  Future<void> getData() async {
    controller.listData.value.clear();
    EasyLoading.show();
    await controller
        .getDebt(fromDay: fromDay, toDay: toDay)
        .whenComplete(() => EasyLoading.dismiss());
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    controller.sumCloan.value = 0;
    controller.sumCFEE.value = 0;
    controller.sumCloanIn.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).margin_debt,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(height: 1).paddingZero,
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: DayInput(
                      initialDay: fromDay,
                      firstDay: firstDay,
                      lastDay: lastDay,
                      onChanged: (value) {
                        setState(() {
                          fromDay = value;
                        });
                        getData();
                      },
                      color: themeMode.isLight
                          ? AppColors.neutral_06
                          : AppColors.text_black_1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('-'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DayInput(
                      initialDay: toDay,
                      firstDay: firstDay,
                      lastDay: lastDay,
                      onChanged: (value) {
                        setState(() {
                          toDay = value;
                        });
                        getData();
                      },
                      color: themeMode.isLight
                          ? AppColors.neutral_06
                          : AppColors.text_black_1,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: themeMode.isLight
                      ? AppColors.light_bg
                      : AppColors.text_black_1,
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(16),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).Total_remaining_debt,
                          style: AppTextStyle.bodyMedium_14.copyWith(
                            color: AppColors.neutral_03,
                          ),
                        ),
                        Text(
                          NumUtils.formatDouble(controller.sumCloan.value),
                          style: AppTextStyle.bodyMedium_14.copyWith(
                            color: AppColors.neutral_01,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).Total_interest,
                          style: AppTextStyle.bodyMedium_14.copyWith(
                            color: AppColors.neutral_03,
                          ),
                        ),
                        Text(
                          NumUtils.formatDouble(controller.sumCFEE.value),
                          style: AppTextStyle.bodyMedium_14.copyWith(
                            color: AppColors.neutral_01,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(
              () {
                if (controller.listData.value.isEmpty) {
                  return const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: EmptyListWidget());
                }
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: themeMode.isLight
                          ? AppColors.light_bg
                          : AppColors.text_black_1,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      for (var detail in controller.listData.value)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: ItemMarginDebtWidget(detail: detail),
                        )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: SizedBox.square(
        dimension: 40,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            onTap: () async {
              final StockModel? aaa = await controller.dataCenterService
                  .getStockModelFromStockCode("AAA");
              if (mounted) {}
              StockOrderISheet(null).show(
                context,
                StockOrderSheet(
                  stockModel: aaa,
                  orderData: null,
                ),
              );
            },
            child: Ink(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: AppColors.primary_01,
              ),
              child: SvgPicture.asset(
                AppImages.arrange_circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
