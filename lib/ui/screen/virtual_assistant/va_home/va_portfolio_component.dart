import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/va_portfolio_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../widget/icon/sheet_header.dart';
import '../../../widget/input/interval_input.dart';
import '../../../widget/input/thousand_separator_input_formatter.dart';
import '../../stock_detail/sheet/info_sheet.dart';
import '../interval_input_custom2.dart';

class VAPortfolioComponent extends StatefulWidget {
  const VAPortfolioComponent(
      {super.key,
      required this.item,
      this.onTap,
      this.onHold,
      this.stockModel});

  final VAPortfolioItem item;
  final StockModel? stockModel;
  final VoidCallback? onTap;
  final VoidCallback? onHold;

  @override
  State<VAPortfolioComponent> createState() => _VAPortfolioComponentState();
}

class _VAPortfolioComponentState extends State<VAPortfolioComponent>
    with AppValidator {
  final IDataCenterService dataCenterService = DataCenterService();

  final TextEditingController maximumRiskController = TextEditingController();
  final TextEditingController fixedWeightController = TextEditingController();
  final TextEditingController proportionalWeightController =
      TextEditingController();
  final TextEditingController priceSellController = TextEditingController();
  final TextEditingController priceBuyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant VAPortfolioComponent oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final Widget changePcWidget;
    final Widget lastPriceWidget;
    final Widget name;

    if (widget.stockModel == null) {
      name = Text(
        "",
        style:
            AppTextStyle.labelMedium_12.copyWith(color: AppColors.neutral_03),
        overflow: TextOverflow.ellipsis,
      );
      changePcWidget = Text(
        "-%",
        style: AppTextStyle.labelMedium_12.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.semantic_02,
        ),
      );
      lastPriceWidget = Row(
        children: [
          Image.asset(
            AppImages.prefix_ref_icon,
            width: 12,
            height: 12,
          ),
          const SizedBox(width: 3),
          Text(
            "-",
            maxLines: 1,
            style: AppTextStyle.labelMedium_12.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppColors.semantic_02,
            ),
          )
        ],
      );
    } else {
      name = Text(
        widget.stockModel!.stock.nameShort ?? "",
        style:
            AppTextStyle.labelMedium_12.copyWith(color: AppColors.neutral_03),
        overflow: TextOverflow.ellipsis,
      );
      changePcWidget = Obx(() => Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            decoration: BoxDecoration(
                color: widget.stockModel!.stockData.bgColor(themeMode),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            child: Text(
              "${widget.stockModel!.stockData.changePc.value ?? "-"}%",
              style: AppTextStyle.labelMedium_12.copyWith(
                fontWeight: FontWeight.w600,
                color: widget.stockModel!.stockData.color,
              ),
            ),
          ));
      lastPriceWidget = Obx(() {
        return Row(
          children: [
            widget.stockModel!.stockData.prefixIcon(size: 12),
            const SizedBox(width: 3),
            Text(
              widget.stockModel!.stockData.lastPrice.value?.toString() ?? "-",
              maxLines: 1,
              style: AppTextStyle.labelMedium_12.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: widget.stockModel!.stockData.color,
              ),
            )
          ],
        );
      });
    }

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: InkWell(
        onTap: () {
          if (widget.stockModel != null) {
            if (widget.onTap != null) {
              return widget.onTap!.call();
            } else {
              const InfoISheet().show(
                context,
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SheetHeader(
                          title: 'Cài đặt thiết lập danh mục',
                          implementBackButton: false,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            StockIcon(
                              stockCode: widget.item.stockCode,
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [Text(widget.item.stockCode)],
                                  ),
                                  Row(
                                    children: [
                                      lastPriceWidget,
                                      const SizedBox(width: 4),
                                      changePcWidget,
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text('Rủi ro tối đa'),
                        const SizedBox(
                          height: 16,
                        ),
                        IntervalInputCustom2(
                          controller: maximumRiskController,
                          labelText: 'Rủi ro tối đa',
                          defaultValue: 0,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tỷ lệ chốt cắt lỗ',
                              style: AppTextStyle.labelMedium_12,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: IntervalInput(
                                controller: priceBuyController,
                                labelText: S.of(context).price,
                                interval: (value) => 0.1,
                                defaultValue: 0,
                                // onChanged: onChangedPrice,
                                // onTextChanged: _onPriceChangeHandler,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Material(
                                child: TextFormField(
                                  controller: priceSellController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: [
                                    ThousandsSeparatorInputFormatter()
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Bán khi giá',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                    // prefixIcon: Text(
                                    //
                                    //   "≥",
                                    //   style: AppTextStyle.bodySmall_8
                                    //       .copyWith(
                                    //           color: AppColors.semantic_01)
                                    //       .copyWith(fontSize: 20),
                                    // ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          AppImages.icon_percent),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text('Khối lượng'),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: fixedWeightController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  ThousandsSeparatorInputFormatter()
                                ],
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 15, right: 15),
                                  labelText: 'Khối lượng cố định',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  floatingLabelAlignment:
                                      FloatingLabelAlignment.start,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: IntervalInputCustom2(
                                controller: proportionalWeightController,
                                labelText: 'Khối lượng  theo tỷ lệ',
                                validator: volumnValidator,
                                // onChanged: onChangeVol,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.color_secondary,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Lưu',
                              style: AppTextStyle.textButtonTextStyle
                                  .copyWith(color: AppColors.neutral_05),
                            ),
                          ),
                          onTap: () {
                            // Click để lưu
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
              return;
            }
          }
        },
        onLongPress: widget.onHold,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Ink(
          // alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: themeMode.isDark ? AppColors.bg_2 : AppColors.neutral_07,
          ),
          child: Row(
            children: [
              StockIcon(
                stockCode: widget.item.stockCode,
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.item.stockCode,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Flexible(child: name),
                  ],
                ),
              ),
              Expanded(
                  child: Row(
                children: [
                  Text("${NumUtils.formatDouble(widget.item.setting.rrMax)}%")
                ],
              )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "≤ ${NumUtils.formatDouble(widget.item.setting.buy)}%",
                    style: AppTextStyle.bodySmall_8
                        .copyWith(color: AppColors.semantic_01),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "≥ ${NumUtils.formatDouble(widget.item.setting.sell)}%",
                    style: AppTextStyle.bodySmall_8
                        .copyWith(color: AppColors.semantic_03),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        lastPriceWidget,
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        changePcWidget,
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
