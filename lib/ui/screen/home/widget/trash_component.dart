import 'package:dtnd/=models=/response/market/stock_model.dart';
import 'package:dtnd/=models=/response/trash_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/screen/stock_detail/stock_detail_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/chart/simple_line_area_chart.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrashComponent extends StatefulWidget {
  const TrashComponent(
      {super.key, required this.snapshotData, this.onTap, this.onHold});

  final TrashModel snapshotData;
  final VoidCallback? onTap;
  final VoidCallback? onHold;

  @override
  State<TrashComponent> createState() => _TrashComponentState();
}

class _TrashComponentState extends State<TrashComponent> {
  final IDataCenterService dataCenterService = DataCenterService();
  late TrashModel snapshotData;
  StockModel? stockModel;

  @override
  void initState() {
    snapshotData = widget.snapshotData;
    super.initState();
    getStockModel();
  }

  Future<void> getStockModel() async {
    final response = await dataCenterService
        .getStocksModelsFromStockCodes([widget.snapshotData.sTOCKCODE]);
    if (response?.isNotEmpty ?? false) {
      stockModel = response!.first;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void didUpdateWidget(covariant TrashComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.snapshotData.sTOCKCODE != widget.snapshotData.sTOCKCODE) {
      if (mounted) {
        setState(() {
          stockModel = null;
          snapshotData = widget.snapshotData;
        });
        getStockModel();
      }
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
    final Widget volWidget;
    final Widget chartWidget;
    if (stockModel == null) {
      changePcWidget = Text(
        "${snapshotData.pERCENTCHANGE ?? "-"}%",
        style: AppTextStyle.labelMedium_12.copyWith(
          fontWeight: FontWeight.w600,
          color: snapshotData.color,
        ),
      );
      lastPriceWidget = Row(
        children: [
          snapshotData.prefixIcon(size: 12),
          const SizedBox(width: 3),
          Text(
            snapshotData.pRICE?.toString() ?? "-",
            maxLines: 1,
            style: AppTextStyle.labelMedium_12.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: snapshotData.color,
            ),
          )
        ],
      );
      volWidget = Text(
        "${NumUtils.formatInteger10(snapshotData.kLGD)} CP",
        style: AppTextStyle.labelMedium_12.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.neutral_03,
        ),
      );
      chartWidget = SimpleLineAreaChart(
        data: snapshotData.cHART,
        annotation: snapshotData.cHART?.first,
        color: snapshotData.color,
      );
    } else {
      changePcWidget = ObxValue<Rx<bool>>((hasSocketData) {
        if (hasSocketData.value) {
          return Obx(() => Text(
                "${stockModel!.stockData.changePc.value ?? "-"}%",
                style: AppTextStyle.labelMedium_12.copyWith(
                  fontWeight: FontWeight.w600,
                  color: stockModel?.stockData.color ?? AppColors.semantic_02,
                ),
              ));
        } else {
          return Text(
            "${snapshotData.pERCENTCHANGE ?? "-"}%",
            style: AppTextStyle.labelMedium_12.copyWith(
              fontWeight: FontWeight.w600,
              color: snapshotData.color,
            ),
          );
        }
      }, stockModel!.hasSocketData);
      lastPriceWidget = ObxValue<Rx<bool>>((hasSocketData) {
        if (hasSocketData.value) {
          return Obx(() {
            return Row(
              children: [
                stockModel?.stockData.prefixIcon(size: 12) ??
                    Image.asset(
                      AppImages.prefix_ref_icon,
                      width: 12,
                      height: 12,
                    ),
                const SizedBox(width: 3),
                Text(
                  stockModel?.stockData.lastPrice.value?.toString() ?? "-",
                  maxLines: 1,
                  style: AppTextStyle.labelMedium_12.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: stockModel?.stockData.color ?? AppColors.semantic_02,
                  ),
                )
              ],
            );
          });
        } else {
          return Row(
            children: [
              snapshotData.prefixIcon(size: 12),
              const SizedBox(width: 3),
              Text(
                snapshotData.pRICE?.toString() ?? "-",
                maxLines: 1,
                style: AppTextStyle.labelMedium_12.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: snapshotData.color,
                ),
              )
            ],
          );
        }
      }, stockModel!.hasSocketData);
      volWidget = ObxValue<Rx<bool>>((hasSocketData) {
        if (hasSocketData.value) {
          return Obx(() => Text(
                "${NumUtils.formatInteger10(stockModel?.stockData.lot.value ?? 0)} CP",
                style: AppTextStyle.labelMedium_12.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutral_03,
                ),
              ));
        } else {
          return Text(
            "${NumUtils.formatInteger10(snapshotData.kLGD)} CP",
            style: AppTextStyle.labelMedium_12.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.neutral_03,
            ),
          );
        }
      }, stockModel!.hasSocketData);
      chartWidget = Obx(() {
        stockModel!.stockData.lastPrice.value;
        final num? annotation = snapshotData.cHART?.first;
        final Color color;
        if (stockModel != null) {
          color = stockModel!.stockData.color;
        } else {
          color = snapshotData.color;
        }
        return SimpleLineAreaChart(
          data: snapshotData.cHART,
          annotation: annotation,
          color: color,
        );
      });
    }
    return Material(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: InkWell(
        onTap: () {
          if (stockModel != null) {
            if (widget.onTap != null) {
              return widget.onTap!.call();
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    StockDetailScreen(stockModel: stockModel!),
              ));
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
            color: themeMode.isDark
                ? AppColors.text_black_1
                : AppColors.neutral_07,
          ),
          child: Row(
            children: [
              StockIcon(
                stockCode: widget.snapshotData.sTOCKCODE,
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.snapshotData.sTOCKCODE,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: themeMode.isLight
                              ? AppColors.text_black_1
                              : AppColors.neutral_07),
                    ),
                    changePcWidget,
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: SizedBox(width: 120, child: chartWidget),
                ),
              ),
              SizedBox(
                width: 88,
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
                        volWidget,
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
