import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../=models=/response/get_bedt_model.dart';
import '../../../../../=models=/response/stock_model.dart';
import '../../component/asset_grid_element.dart';

class ItemMarginDebtWidget extends StatefulWidget {
  const ItemMarginDebtWidget({
    super.key,
    this.onHold,
    this.onExpand,
    required this.detail,
  });

  final ValueChanged<UnexecutedRightModel?>? onExpand;
  final VoidCallback? onHold;
  final GetBedtModel? detail;

  @override
  State<ItemMarginDebtWidget> createState() => _ItemRealizedState();
}

class _ItemRealizedState extends State<ItemMarginDebtWidget> {
  final IDataCenterService dataCenterService = DataCenterService();
  bool expand = false;
  bool isShow = true;
  StockModel? stockModel;

  void onTap() {
    setState(() {
      isShow = !isShow;
      expand = !expand;
    });
    if (expand) {}
  }

  @override
  void initState() {
    super.initState();
    getStockModel();
  }

  Future<void> getStockModel() async {
    final response = await dataCenterService.getStocksModelsFromStockCodes(
        [widget.detail?.cBANKCODE.toString() ?? '']);
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            color: themeMode.isDark ? AppColors.bg_2 : AppColors.neutral_06,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: AppColors.light_bg, shape: BoxShape.circle),
                    child: SvgPicture.asset(AppImages.margin_debt_icon),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.detail?.cLOANID ?? '',
                            style: AppTextStyle.bodyMedium_14
                                .copyWith(color: AppColors.neutral_01)),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Lãi suất ${NumUtils.formatDouble(widget.detail?.cINTERESTRATE)}%',
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.labelMedium_12
                                    .copyWith(color: AppColors.semantic_04),
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
                          'Ngày hết hạn',
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_04),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.detail?.cEXPIREDATE1 ?? '',
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_01),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Nợ còn lại',
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_04),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          NumUtils.formatDouble(widget.detail?.cLOAN),
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_01),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Lãi",
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_04),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          NumUtils.formatDouble(widget.detail?.cFEE),
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: stockModel?.stockData.color),
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
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: AppColors.neutral_06,
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Expanded(
                              child: AssetGridElement(
                                  contentPadding: const EdgeInsets.all(5),
                                  element: {
                                    "Ngày vay": widget.detail?.cDELIVERDATE,
                                  }),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(
                                contentPadding: const EdgeInsets.all(5),
                                element: {
                                  "Ngày tính lãi": NumUtils.formatDouble(
                                      widget.detail?.cINTERESTRATE),
                                },
                              ),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(
                                  contentPadding: const EdgeInsets.all(5),
                                  element: {
                                    "Số ngày vay": NumUtils.formatDouble(
                                        widget.detail?.cCOUNTDAY),
                                  }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Flexible(
                        child: Row(
                          children: [
                            Expanded(
                              child: AssetGridElement(
                                contentPadding: const EdgeInsets.all(5),
                                element: {
                                  "Dư nợ gốc": NumUtils.formatDouble(
                                      widget.detail?.cLOANIN)
                                },
                              ),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(
                                contentPadding: const EdgeInsets.all(5),
                                element: {
                                  "Đã trả": NumUtils.formatDouble(
                                      widget.detail?.cLOANOUT)
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
                color: themeMode.isDark ? AppColors.bg_2 : AppColors.neutral_05,
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
