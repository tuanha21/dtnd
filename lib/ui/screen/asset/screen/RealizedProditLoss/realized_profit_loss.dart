import 'package:dtnd/ui/screen/asset/screen/RealizedProditLoss/realized_profit_loss_controller.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../=models=/response/share_earned_model.dart';
import '../../../../../=models=/response/stock_model.dart';
import '../../../../../config/service/app_services.dart';
import '../../../../../data/i_data_center_service.dart';
import '../../../../../data/implementations/data_center_service.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utilities/num_utils.dart';
import '../../../../../utilities/time_utils.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/app_image.dart';
import '../../../../widget/calendar/day_input.dart';
import '../../../../widget/expanded_widget.dart';
import '../../../../widget/my_appbar.dart';
import '../../../../widget/overlay/custom_dialog.dart';
import '../../../../widget/overlay/login_first_dialog.dart';
import '../../../exchange_stock/stock_order/business/stock_order_flow.dart';
import '../../../exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import '../../../login/login_screen.dart';
import 'item_realized_widget.dart';

class RealizedProfitLoss extends StatefulWidget {
  const RealizedProfitLoss({super.key});

  @override
  State<RealizedProfitLoss> createState() => _RealizedProfitLossState();
}

class _RealizedProfitLossState extends State<RealizedProfitLoss> {
  final RealizedProfitLossController controller =
      RealizedProfitLossController();

  late DateTime fromDay;
  late DateTime toDay;
  late DateTime firstDay;
  late DateTime lastDay;

  final IDataCenterService dataCenterService = DataCenterService();

  void onChanged(String code) {
    if (code.isNotEmpty) {
      setState(() {
        controller.searching = true;
        try {
          controller.Search(fromDay, toDay, code.toString());
        } catch (e) {}
      });
    } else {
      setState(() {
        controller.searching = false;
      });
    }
  }

  void onFABTapped() async {
    if (controller.userService.isLogin) {
      final toLogin = await showDialog<bool>(
        context: context,
        builder: (context) {
          return const LoginFirstDialog();
        },
      );
      if (toLogin ?? false) {
        if (!mounted) return;
        final result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
        if (result && mounted) {
          if (controller.localStorageService.biometricsRegistered) {
            final reg = await showDialog<bool>(
              context: context,
              builder: (context) {
                return CustomDialog(
                  textButtonAction: 'Đồng ý',
                  textButtonExit: 'Để sau',
                  title: 'Đăng nhập bằng sinh trắc học',
                  content:
                      'Bạn chưa đăng ký đăng nhập bằng sinh trắc học\nBạn có muốn đăng ký ngay bây giờ không?',
                  action: () => Navigator.of(context).pop(true),
                );
              },
            );
            if (reg ?? false) {
              if (!mounted) return;
              final auth = await controller.localStorageService
                  .biometricsValidate()
                  .onError((error, stackTrace) => false);
              if (auth) {
                await controller.localStorageService.registerBiometrics();
              }
            }
          }
          return onFABTapped();
        }
      }
    } else {
      // return StockOrderISheet(widget.stockModel).showSheet(context, );

      // StockOrderISheet(widget.stockModel).show(
      //     context,
      //     StockOrderSheet(
      //       stockModel: widget.stockModel,
      //       orderData: null,
      //     ));
    }
  }

  @override
  void initState() {
    fromDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(1));
    toDay = DateTime.now();
    firstDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(3));
    lastDay = toDay;
    super.initState();
    EasyLoading.show();
    controller
        .getAllShareEarned(fromDay, toDay, '')
        .whenComplete(() => EasyLoading.dismiss());
  }

  Future<void> getData() async {
    controller.shareEarnedModel.value?.listDetail.clear();
    EasyLoading.show();
    await controller
        .getAllShareEarned(fromDay, toDay, '')
        .whenComplete(() => EasyLoading.dismiss());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Scaffold(
      appBar: MyAppBar(
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
        title: 'Lãi/lỗ đã thực hiện',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            Column(
              children: [
                Container(
                  color: AppColors.light_bg,
                  height: kToolbarHeight,
                  child: TextField(
                    onChanged: onChanged,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: S.of(context).search_stock,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Image.asset(
                            AppImages.search_icon,
                          ),
                        ),
                        fillColor: AppColors.neutral_07,
                        suffixIconConstraints:
                            const BoxConstraints(maxWidth: 52, maxHeight: 20)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DayInput(
                    background: AppColors.light_bg,
                    initialDay: fromDay,
                    firstDay: firstDay,
                    lastDay: lastDay,
                    onChanged: (value) {
                      setState(() {
                        fromDay = value;
                      });
                      getData();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                const Text('-'),
                const SizedBox(width: 8),
                Expanded(
                  child: DayInput(
                    background: AppColors.light_bg,
                    initialDay: toDay,
                    firstDay: firstDay,
                    lastDay: lastDay,
                    onChanged: (value) {
                      setState(() {
                        toDay = value;
                      });
                      getData();
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.light_bg,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tổng cộng", style: AppTextStyle.labelMedium_12),
                  Text(
                      controller.shareEarnedModel.value?.listDetail
                                  .isNotEmpty ==
                              true
                          ? NumUtils.formatDouble(
                              controller.shareEarnedModel.value?.cEARNEDVALUE ??
                                  0)
                          : '',
                      style: AppTextStyle.labelMedium_12
                          .copyWith(color: AppColors.semantic_01))
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            //
            // Obx(() {
            //   final StockModel? stockModel;
            //   if (i >
            //       controller.listStockModels.value.length - 1) {
            //     stockModel = null;
            //   } else {
            //     stockModel = controller.listStockModels.value
            //         .elementAt(i);
            //   }
            //   return VAPortfolioComponent(
            //     stockModel: stockModel,
            //     item: controller.vaPortfolio.value.listStocks
            //         .elementAt(i),
            //   );
            // }),

            Obx(() {
              if (!controller.searching) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColors.light_bg,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      if (!controller.searching)
                        for (ShareEarnedDetailModel detail
                            in controller.shareEarnedModel.value?.listDetail ??
                                [])
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: ItemRealizedWidget(detail: detail),
                          )
                    ],
                  ),
                );
              } else {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColors.light_bg,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      for (ShareEarnedDetailModel detail
                          in controller.listSearch.value?.listDetail ?? [])
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: ItemRealizedWidget(detail: detail),
                        )
                    ],
                  ),
                );
              } /////
            })
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
              final StockModel? aaa =
                  await dataCenterService.getStockModelFromStockCode("AAA");

              if (mounted) {}
              // return StockOrderISheet(widget.stockModel).showSheet(context, );
              StockOrderISheet(null).show(
                  context,
                  StockOrderSheet(
                    stockModel: aaa,
                    orderData: null,
                  ));
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

class _ExpandableRow extends StatefulWidget {
  const _ExpandableRow({
    required this.icon,
    required this.text,
    required this.value,
    this.child,
  });

  final Widget icon;
  final String text;
  final Widget value;
  final Widget? child;

  @override
  State<_ExpandableRow> createState() => __ExpandableRowState();
}

class __ExpandableRowState extends State<_ExpandableRow> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Ink(
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 32,
                    child: widget.icon,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          widget.text,
                          style: textTheme.labelMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 8),
                        Center(
                          child: AnimatedRotation(
                            turns: expanded ? -0.5 : 0,
                            duration: const Duration(milliseconds: 500),
                            child: SizedBox.square(
                              dimension: 10,
                              child: Image.asset(
                                AppImages.arrow_drop_down_rounded,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.value,
                ],
              ),
            ),
          ),
        ),
        if (widget.child != null)
          ExpandedSection(expand: expanded, child: widget.child!),
      ],
    );
  }
}