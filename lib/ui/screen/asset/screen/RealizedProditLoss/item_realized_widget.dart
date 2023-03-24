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

  void onTap() {
    setState(() {
      expand = !expand;
    });
    if (expand) {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final textTheme = Theme.of(context).textTheme;
    final Widget name;

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
                        SizedBox(
                          width: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.detail?.cSHARECODE ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
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
                          'Ngày',
                          style: AppTextStyle.labelSmall_10
                              .copyWith(color: AppColors.neutral_01),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.detail?.cTRADINGDATE ?? '',
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_03),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Lãi/lỗ",
                          style: AppTextStyle.labelSmall_10
                              .copyWith(color: AppColors.neutral_01),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          NumUtils.formatDouble(widget.detail?.cEARNEDVALUE),
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_03),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "% lãi/lỗ",
                          style: AppTextStyle.labelSmall_10
                              .copyWith(color: AppColors.neutral_01),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.detail?.cEARNEDRATE.toString() ?? '',
                          style: AppTextStyle.labelMedium_12,
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
                              child: AssetGridElement(element: {
                                "Giá bán": NumUtils.formatDouble(
                                    widget.detail?.cSHAREPRICE),
                              }),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(element: {
                                "Giá trị bán": NumUtils.formatDouble(
                                    widget.detail?.cSHAREPRICE)
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
                              child: AssetGridElement(element: {
                                "Giá vốn": NumUtils.formatDouble(
                                    widget.detail?.cAVERAGEPRICE),
                              }),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(
                                element: {
                                  "Giá trị vốn": NumUtils.formatDouble(
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
