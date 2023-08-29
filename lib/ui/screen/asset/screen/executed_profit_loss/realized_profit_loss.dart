import 'package:dtnd/ui/screen/asset/screen/executed_profit_loss/realized_profit_loss_controller.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  StockModel? stockModel;
  bool isLoading = false;

  final ScrollController _scrollController = ScrollController();

  final IDataCenterService dataCenterService = DataCenterService();

  void onChanged(String code) {
    if (code.isNotEmpty) {
      setState(() {
        controller.searching = true;
        try {
          controller.search(fromDay, toDay, code.toString());
        } catch (e) {
          logger.v(e);
        }
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
                  textButtonAction: S.of(context).ok,
                  textButtonExit: S.of(context).later,
                  title: S.of(context).biometric_authentication,
                  content: S.of(context).login_with_biometric,
                  action: () => Navigator.of(context).pop(true),
                  type: TypeAlert.notification,
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
    }
  }

  @override
  void initState() {
    fromDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(1));
    toDay = DateTime.now();
    firstDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(3));
    lastDay = toDay;
    _scrollController.addListener(_scrollListener);
    super.initState();
    EasyLoading.show();
    controller
        .getAllShareEarned(fromDay, toDay, '', 10)
        .whenComplete(() => EasyLoading.dismiss());
  }

  Future<void> getData({int? recordPerPage}) async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    controller.shareEarnedModel.value?.listDetail.clear();
    EasyLoading.show();
    await controller
        .getAllShareEarned(fromDay, toDay, '', recordPerPage)
        .whenComplete(() => EasyLoading.dismiss());
    setState(() {
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (controller.shareEarnedModel.value!.listDetail.isNotEmpty) {
        getData(
            recordPerPage:
                controller.shareEarnedModel.value!.listDetail.length + 5);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).executed_profit_and_loss,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, right: 16, left: 16, bottom: 16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: themeMode.isLight ? AppColors.light_bg : AppColors.text_black_1,
              ),
              height: kToolbarHeight,
              child: TextField(
                onChanged: onChanged,
                inputFormatters: [UpperCaseTextFormatter()],
                decoration: InputDecoration(
                    hintText: S.of(context).search_stock,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Image.asset(
                        AppImages.search_icon,
                      ),
                    ),
                    fillColor: themeMode.isLight ? AppColors.neutral_07 : AppColors.text_black_1,
                    suffixIconConstraints:
                        const BoxConstraints(maxWidth: 52, maxHeight: 20),
                    disabledBorder: InputBorder.none),
              ),
            ),
            const SizedBox(height: 8),
            Row(
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
                    color: themeMode.isLight ? AppColors.neutral_07 : AppColors.text_black_1,
                  ),
                ),
                const SizedBox(width: 8),
                const Text('-'),
                const SizedBox(width: 8),
                Expanded(
                  child: DayInput(
                    color: themeMode.isLight ? AppColors.neutral_07 : AppColors.text_black_1,
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
              height: 12,
            ),
            Obx(() {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: themeMode.isLight ? AppColors.light_bg : AppColors.bg_share_inside_nav,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).Total,
                        style: AppTextStyle.labelMedium_12),
                    Text(
                      "${NumUtils.formatDouble(controller.shareEarnedModel.value?.cEARNEDVALUE ?? 0)} (${NumUtils.formatDouble(controller.shareEarnedModel.value?.cEARNEDRATE)}%)",
                      style: AppTextStyle.labelMedium_12.copyWith(
                        color: controller.shareEarnedModel.value?.color,
                      ),
                    )
                  ],
                ),
              );
            }),
            Container(
              height: 16,
            ),
            Expanded(
              child: Obx(
                () {
                  if (controller.shareEarnedModel.value?.listDetail.isEmpty ??
                      true) {
                    return const Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: EmptyListWidget());
                  }
                  if (!controller.searching) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: themeMode.isLight ? AppColors.light_bg : AppColors.bg_share_inside_nav,
                          borderRadius: BorderRadius.circular(12)),
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: controller
                                .shareEarnedModel.value!.listDetail.length +
                            1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index <
                              controller
                                  .shareEarnedModel.value!.listDetail.length) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: ItemRealizedWidget(
                                      detail: controller.shareEarnedModel.value!
                                          .listDetail[index]),
                                )
                              ],
                            );
                          } else if (index ==
                                  controller.shareEarnedModel.value!.listDetail
                                      .length &&
                              isLoading) {
                            return _buildLoader();
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: themeMode.isLight ? AppColors.light_bg : AppColors.bg_share_inside_nav,
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
                },
              ),
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

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

// padding: const EdgeInsets.only(top: 5, right: 16, left: 16, bottom: 16),
//

Widget _buildLoader() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: const CircularProgressIndicator(),
  );
}
