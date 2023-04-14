import 'package:dtnd/=models=/response/order_history_model.dart';
import 'package:dtnd/=models=/response/share_earned_model.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/screen/asset_stock_detail/asset_stock_detail_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/ui/widget/picker/datetime_picker_widget.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClosedDealTab extends StatefulWidget {
  const ClosedDealTab({super.key, required this.stockCode});
  final String stockCode;
  @override
  State<ClosedDealTab> createState() => _ClosedDealTabState();
}

class _ClosedDealTabState extends State<ClosedDealTab>
    with AutomaticKeepAliveClientMixin {
  final IUserService userService = UserService();
  final IExchangeService exchangeService = ExchangeService();
  late final AssetStockDetailController assetStockDetailController;
  late final TextEditingController fromdayController;
  late final TextEditingController todayController;

  @override
  void initState() {
    assetStockDetailController =
        AssetStockDetailController(stockCode: widget.stockCode);
    fromdayController = TextEditingController(
        text: TimeUtilities.commonTimeFormat
            .format(DateTime.now().subtract(const Duration(days: 7))));
    todayController = TextEditingController(
        text: TimeUtilities.commonTimeFormat.format(DateTime.now()));
    assetStockDetailController.getAllShareEarned(
        fromdayController.text, todayController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: DateTimePickerWidget(
                controller: fromdayController,
                labelText: S.of(context).from_day,
                onChanged: (value) =>
                    assetStockDetailController.getAllShareEarned(
                        fromdayController.text, todayController.text),
              )),
              const SizedBox(width: 16),
              Expanded(
                  child: DateTimePickerWidget(
                controller: todayController,
                labelText: S.of(context).to_day,
                onChanged: (value) =>
                    assetStockDetailController.getAllShareEarned(
                        fromdayController.text, todayController.text),
              ))
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: AppColors.neutral_06),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tổng lãi/lỗ đã đóng",
                      style: textTheme.labelMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Obx(() {
                      // print(assetStockDetailController
                      //     .shareEarnedModel
                      //     .value
                      //     ?.cEARNEDVALUE);
                      return Text(
                        "${NumUtils.formatInteger(assetStockDetailController.shareEarnedModel.value?.cEARNEDVALUE ?? 0)}đ",
                        style: textTheme.labelMedium,
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Obx(() {
            // print(assetStockDetailController
            //     .shareEarnedModel.value?.listDetail.length);
            if (assetStockDetailController
                    .shareEarnedModel.value?.listDetail.isEmpty ??
                true) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: EmptyListWidget(),
              );
            }
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: AppColors.neutral_06,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                children: [
                  for (int i = 0;
                      i <
                          assetStockDetailController
                              .shareEarnedModel.value!.listDetail.length;
                      i++)
                    Column(
                      children: [
                        if (i != 0)
                          const Divider(
                            height: 17,
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox.square(
                                    dimension: 20,
                                    child: Image.asset(AppImages.calendar_2)),
                                const SizedBox(width: 8),
                                Text(assetStockDetailController
                                        .shareEarnedModel.value!.listDetail
                                        .elementAt(i)
                                        .cTRADINGDATE ??
                                    "-"),
                              ],
                            ),
                            Text(
                              "Đã khớp",
                              style: AppTextStyle.bodyMedium_14
                                  .copyWith(color: AppColors.semantic_01),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).volumn,
                                  style: AppTextStyle.labelSmall_10.copyWith(
                                    color: AppColors.neutral_03,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  NumUtils.formatInteger(
                                      assetStockDetailController
                                              .shareEarnedModel
                                              .value!
                                              .listDetail
                                              .elementAt(i)
                                              .cSHAREVOLUME ??
                                          0),
                                  style: AppTextStyle.labelSmall_10,
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "Giá bán",
                                  style: AppTextStyle.labelSmall_10.copyWith(
                                    color: AppColors.neutral_03,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  NumUtils.formatInteger(
                                      (assetStockDetailController
                                                  .shareEarnedModel
                                                  .value!
                                                  .listDetail
                                                  .elementAt(i)
                                                  .cSHAREPRICE ??
                                              0) /
                                          1000),
                                  style: AppTextStyle.labelSmall_10,
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "Giá vốn",
                                  style: AppTextStyle.labelSmall_10.copyWith(
                                    color: AppColors.neutral_03,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  NumUtils.formatInteger(
                                      (assetStockDetailController
                                                  .shareEarnedModel
                                                  .value!
                                                  .listDetail
                                                  .elementAt(i)
                                                  .cAVERAGEPRICE ??
                                              0) /
                                          1000),
                                  style: AppTextStyle.labelSmall_10,
                                )
                              ],
                            )),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Lãi/lỗ",
                                    style: AppTextStyle.labelSmall_10.copyWith(
                                      color: AppColors.neutral_03,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    NumUtils.formatInteger(
                                        (assetStockDetailController
                                                .shareEarnedModel
                                                .value!
                                                .listDetail
                                                .elementAt(i)
                                                .cEARNEDVALUE ??
                                            0)),
                                    style: AppTextStyle.labelSmall_10,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                ],
              ),
            );
          }),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}