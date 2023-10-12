import 'package:dtnd/=models=/local/va_portfolio_model.dart';
import 'package:dtnd/=models=/response/market/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_home/sheet/va_portfolio_item_setting_sheet.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../stock_detail/sheet/info_sheet.dart';

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
  final TextEditingController priceController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();

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
      changePcWidget = Obx(() => Text(
            "${widget.stockModel!.stockData.changePc.value ?? "-"}%",
            style: AppTextStyle.labelMedium_12.copyWith(
              fontWeight: FontWeight.w600,
              color: widget.stockModel!.stockData.color,
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
                  VAPortfolioItemSettingSheet(
                    item: widget.item,
                  ));
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
                stockCode: widget.item.code,
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.item.code,
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
