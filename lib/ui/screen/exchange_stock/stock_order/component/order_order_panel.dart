import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/search/search_screen.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/three_price.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'overbought_sell_widget.dart';

final GlobalKey<FormFieldState<StockModel?>> stockModelFormKey =
    GlobalKey<FormFieldState<StockModel?>>();

class OrderOrderPanel extends StatelessWidget {
  const OrderOrderPanel(
      {super.key,
      this.stockModel,
      required this.onChangeStock,
      required this.onValidate});
  final StockModel? stockModel;
  final void Function(StockModel) onChangeStock;
  final ValueChanged<String?> onValidate;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        FormField<StockModel?>(
            key: stockModelFormKey,
            validator: (value) {
              if (value == null) {
                const String errorTxt = "Vui lòng chọn mã CK";
                onValidate.call(errorTxt);
                return errorTxt;
              }
              onValidate.call(null);
              return null;
            },
            initialValue: stockModel,
            builder: (formState) {
              final BoxBorder? border;
              if (formState.hasError) {
                border = Border.all(color: AppColors.semantic_03);
              } else {
                border = null;
              }
              return Material(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: InkWell(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ))
                        .then((value) async {
                      if (value is Stock) {
                        DataCenterService().getStockModelsFromStockCodes(
                            [value.stockCode]).then((stockModels) {
                          if (stockModels?.isNotEmpty ?? false) {
                            formState.didChange(stockModels!.first);
                            formState.validate();
                            return onChangeStock.call(stockModels.first);
                          }
                        });
                      }
                    });
                  },
                  child: Ink(
                    // height: 60,
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 8, left: 16, right: 16),
                    decoration: BoxDecoration(
                      border: border,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      color: AppColors.neutral_05,
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${stockModel?.stock.stockCode ?? "-"} (${stockModel?.stock.postTo?.name ?? "-"})",
                              style: textTheme.titleSmall,
                            ),
                            const SizedBox(width: 4),
                            SizedBox.square(
                              dimension: 13,
                              child: Image.asset(AppImages.search_icon),
                            )
                          ],
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (stockModel != null) {
                                return Obx(
                                  () => Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            NumUtils.formatDouble(stockModel!
                                                .stockData.lastPrice.value),
                                            style: AppTextStyle.bodyMedium_14
                                                .copyWith(
                                              color:
                                                  stockModel!.stockData.color,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            "(${NumUtils.formatDouble(stockModel?.stockData.ot.value)} ${NumUtils.formatDouble(stockModel?.stockData.changePc.value)}%)",
                                            style: AppTextStyle.labelSmall_10
                                                .copyWith(
                                                    color: stockModel!
                                                        .stockData.color,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            NumUtils.formatInteger10(
                                                stockModel!.stockData.lot.value,
                                                "-"),
                                            style: AppTextStyle.labelSmall_10
                                                .copyWith(
                                              color: AppColors.neutral_02,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            " CP",
                                            style: AppTextStyle.labelSmall_10
                                                .copyWith(
                                              color: AppColors.neutral_03,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            NumUtils.formatDouble(
                                                (stockModel!.stockData.value ??
                                                        0) /
                                                    1000000000,
                                                "-"),
                                            style: AppTextStyle.labelSmall_10
                                                .copyWith(
                                              color: AppColors.neutral_02,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            " Tỷ",
                                            style: AppTextStyle.labelSmall_10
                                                .copyWith(
                                              color: AppColors.neutral_03,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "-",
                                        style:
                                            AppTextStyle.bodyMedium_14.copyWith(
                                          color: AppColors.semantic_02,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        "(- -%)",
                                        style: AppTextStyle.labelSmall_10
                                            .copyWith(
                                                color: AppColors.semantic_02,
                                                fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "-",
                                        style:
                                            AppTextStyle.labelSmall_10.copyWith(
                                          color: AppColors.neutral_02,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        " CP",
                                        style:
                                            AppTextStyle.labelSmall_10.copyWith(
                                          color: AppColors.neutral_03,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "-",
                                        style:
                                            AppTextStyle.labelSmall_10.copyWith(
                                          color: AppColors.neutral_02,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        " Tỷ",
                                        style:
                                            AppTextStyle.labelSmall_10.copyWith(
                                          color: AppColors.neutral_03,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
        Container(
          padding:
              const EdgeInsets.only(bottom: 16, top: 40, left: 16, right: 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            color: AppColors.neutral_06,
          ),
          child: Column(
            children: [
              ThreePrices(stockModel: stockModel),
              // Obx(() => Container(
              //       height: 4,
              //     )),
              const SizedBox(height: 4),
              OverboughtSellWidget(stockModel: stockModel),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  color: AppColors.neutral_04,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        S.of(context).floor,
                        style: AppTextStyle.labelSmall_10
                            .copyWith(color: AppColors.neutral_03),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        stockModel?.stockData.f.value?.toString() ?? "-",
                        style: AppTextStyle.labelMedium_12.copyWith(
                            color: AppColors.semantic_04,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).ref,
                        style: AppTextStyle.labelSmall_10
                            .copyWith(color: AppColors.neutral_03),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        stockModel?.stockData.r.value?.toString() ?? "-",
                        style: AppTextStyle.labelMedium_12.copyWith(
                            color: AppColors.semantic_02,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).ceil,
                        style: AppTextStyle.labelSmall_10
                            .copyWith(color: AppColors.neutral_03),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        stockModel?.stockData.c.value?.toString() ?? "-",
                        style: AppTextStyle.labelMedium_12.copyWith(
                            color: AppColors.semantic_05,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
