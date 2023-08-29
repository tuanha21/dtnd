import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/=models=/response/share_earned_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import '../../../../../=models=/response/stock.dart';
import '../../../../../=models=/response/stock_model.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widget/icon/stock_icon.dart';
import '../../component/asset_grid_element.dart';

class ItemRealizedWidget extends StatefulWidget {
  const ItemRealizedWidget({
    super.key,
    this.onHold,
    this.onExpand,
    required this.detail,
  });

  final ValueChanged<UnexecutedRightModel?>? onExpand;
  final VoidCallback? onHold;
  final ShareEarnedDetailModel? detail;

  @override
  State<ItemRealizedWidget> createState() => _ItemRealizedState();
}

class _ItemRealizedState extends State<ItemRealizedWidget> {
  final IDataCenterService dataCenterService = DataCenterService();
  bool expand = false;
  Stock? stock;
  StockModel? stockModel;

  void onTap() {
    setState(() {
      expand = !expand;
    });
    if (expand) {}
  }

  @override
  void initState() {
    super.initState();
    getStock(widget.detail?.cSHARECODE);
    getStockModel();
  }

  void getStock(String? stockCode) async {
    if (stockCode == null) {
      return;
    }
    setState(() {
      stock = dataCenterService.getStockFromStockCode(stockCode);
    });
  }

  Future<void> getStockModel() async {
    final response = await dataCenterService.getStocksModelsFromStockCodes(
        [widget.detail?.cSHARECODE.toString() ?? '']);
    if (response?.isNotEmpty ?? false) {
      stockModel = response!.first;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    // final textTheme = Theme.of(context).textTheme;
    // final Widget name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            color: themeMode.isDark ? AppColors.text_black_1 : AppColors.neutral_06,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  StockIcon(
                    stockCode: widget.detail?.cSHARECODE,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.detail?.cSHARECODE ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                stock?.nameShort ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.labelMedium_12
                                    .copyWith(color: AppColors.neutral_03),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).date_translations,
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_04),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.detail?.cTRADINGDATE ?? '',
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: themeMode.isLight ? AppColors.neutral_01 : AppColors.neutral_07),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).sold_vol,
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_04),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          NumUtils.formatDouble(widget.detail?.cSHAREVOLUME),
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: themeMode.isLight ? AppColors.neutral_01 : AppColors.neutral_07),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).profit_and_loss,
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_04),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          NumUtils.formatDouble(widget.detail?.cEARNEDVALUE),
                          style: AppTextStyle.labelMedium_12.copyWith(
                              color: (widget.detail?.cEARNEDRATE ?? 0) > 0
                                  ? AppColors.semantic_01
                                  : AppColors.semantic_03),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "%${S.of(context).profit_and_loss}",
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_04),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          NumUtils.formatDouble(widget.detail?.cEARNEDRATE),
                          style: AppTextStyle.labelMedium_12.copyWith(
                              color: (widget.detail?.cEARNEDRATE ?? 0) > 0
                                  ? AppColors.semantic_01
                                  : AppColors.semantic_03),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ExpandedSection(
                expand: expand,
                child: Container(
                  height: 90,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: themeMode.isLight ? AppColors.neutral_06 : AppColors.neutral_03,
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Expanded(
                              child: AssetGridElement(contentPadding:const EdgeInsets.all(5) ,element: {
                                S.of(context).selling_price: NumUtils.formatDouble(
                                    widget.detail?.cSHAREPRICE),
                              }),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(contentPadding:const EdgeInsets.all(5) ,
                                element: {
                                  S.of(context).tax_fee: NumUtils.formatDouble(
                                      widget.detail?.cCOMMVALUE)
                                },
                              ),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(contentPadding:const EdgeInsets.all(5) ,
                                element: {
                                  S.of(context).sale_value: NumUtils.formatDouble(
                                      ((((widget
                                                      .detail?.cSHAREPRICE!
                                                      .toDouble() ??
                                                  0) *
                                              (widget.detail?.cSHAREVOLUME!
                                                      .toDouble() ??
                                                  0)) -
                                          (widget.detail?.cCOMMVALUE
                                                  ?.toDouble() ??
                                              0))))
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Flexible(
                        child: Row(
                          children: [
                            Expanded(
                              child: AssetGridElement(contentPadding:const EdgeInsets.all(5) ,element: {
                                S.of(context).cost_price: NumUtils.formatDouble(
                                    widget.detail?.cAVERAGEPRICE),
                              }),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(contentPadding:const EdgeInsets.all(5) ,
                                element: {
                                  S.of(context).cost_value: NumUtils.formatDouble(
                                      widget.detail?.cCOSTVALUE)
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Material(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(12)),
          child: InkWell(
            onTap: onTap,
            onLongPress: widget.onHold,
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(12)),
            child: Ink(
              height: 16,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(12)),
                color: themeMode.isDark ? AppColors.text_black_1 : AppColors.neutral_05,
              ),
              child: Center(
                child: AnimatedRotation(
                  turns: expand ? -0.5 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    AppImages.arrow_drop_down_rounded,
                    width: 10,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
