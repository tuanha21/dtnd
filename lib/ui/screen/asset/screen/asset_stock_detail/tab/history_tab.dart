import 'package:dtnd/=models=/response/order_history_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/screen/asset_stock_detail/asset_stock_detail_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/calendar/day_input.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/service/app_services.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key, required this.stockCode});
  final String stockCode;
  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab>
    with AutomaticKeepAliveClientMixin {
  final IUserService userService = UserService();
  final IExchangeService exchangeService = ExchangeService();
  late final AssetStockDetailController assetStockDetailController;

  late DateTime fromDay;
  late DateTime toDay;
  late DateTime firstDay;
  late DateTime lastDay;

  final List<OrderHistoryModel> listDatas = [];

  @override
  void initState() {
    fromDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(1));
    toDay = DateTime.now();
    firstDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(3));
    lastDay = toDay;
    assetStockDetailController =
        AssetStockDetailController(stockCode: widget.stockCode);
    // fromdayController = TextEditingController(
    //     text: TimeUtilities.commonTimeFormat
    //         .format(DateTime.now().subtract(const Duration(days: 7))));
    // todayController = TextEditingController(
    //     text: TimeUtilities.commonTimeFormat.format(DateTime.now()));
    // assetStockDetailController.getAllShareEarned(
    //     fromdayController.text, todayController.text);
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final res = await exchangeService.getOrdersHistory(
      userService,
      stockCode: widget.stockCode,
      fromDay: fromDay,
      toDay: toDay,
    );
    if (res.isNotEmpty) {
      listDatas.clear();
      listDatas.addAll(res);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 8),
          // Row(
          //   children: [
          //     Expanded(
          //         child: DateTimePickerWidget(
          //       controller: fromdayController,
          //       labelText: S.of(context).from_day,
          //       onChanged: (value) => getData(),
          //     )),
          //     const SizedBox(width: 16),
          //     Expanded(
          //         child: DateTimePickerWidget(
          //       controller: todayController,
          //       labelText: S.of(context).to_day,
          //       onChanged: (value) => getData(),
          //     ))
          //   ],
          // ),
          Row(
            children: [
              Expanded(
                child: DayInput(
                  initialDay: fromDay,
                  firstDay: firstDay,
                  lastDay: lastDay,
                  color: themeMode.isLight
                      ? AppColors.neutral_06
                      : AppColors.text_black_1,
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
                  initialDay: toDay,
                  firstDay: firstDay,
                  lastDay: lastDay,
                  color: themeMode.isLight
                      ? AppColors.neutral_06
                      : AppColors.text_black_1,
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
          //
          const SizedBox(height: 16),
          if (listDatas.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: EmptyListWidget(),
            )
          else
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: themeMode.isLight
                      ? AppColors.neutral_06
                      : AppColors.text_black_1,
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Column(
                children: [
                  for (int i = 0; i < listDatas.length; i++)
                    Column(
                      children: [
                        if (i != 0)
                          Divider(
                              height: 17,
                              color: themeMode.isLight
                                  ? AppColors.neutral_02
                                  : AppColors.neutral_05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox.square(
                                    dimension: 20,
                                    child: Image.asset(AppImages.calendar_2)),
                                const SizedBox(width: 8),
                                Text(listDatas.elementAt(i).cORDERTIME ?? "-"),
                              ],
                            ),
                            Text(
                              listDatas.elementAt(i).side.toName(context),
                              style: AppTextStyle.bodyMedium_14.copyWith(
                                  color: listDatas.elementAt(i).side.kColor),
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
                                      listDatas.elementAt(i).cORDERVOLUME ?? 0),
                                  style: AppTextStyle.labelSmall_10,
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  S.of(context).match_vol,
                                  style: AppTextStyle.labelSmall_10.copyWith(
                                    color: AppColors.neutral_03,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  NumUtils.formatInteger(
                                      (listDatas.elementAt(i).cMATCHVOL ?? 0)),
                                  style: AppTextStyle.labelSmall_10,
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  S.of(context).match_price,
                                  style: AppTextStyle.labelSmall_10.copyWith(
                                    color: AppColors.neutral_03,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                listDatas.elementAt(i).cMATCHPRICE == 0.0
                                    ? Text(
                                        '-',
                                        style: AppTextStyle.labelSmall_10,
                                      )
                                    : Text(
                                        NumUtils.formatDouble((listDatas
                                                    .elementAt(i)
                                                    .cMATCHPRICE ??
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
                                    S.of(context).td_fee,
                                    style: AppTextStyle.labelSmall_10.copyWith(
                                      color: AppColors.neutral_03,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  listDatas.elementAt(i).cFEEVALUE == 0.0
                                      ? Text(
                                          '_',
                                          style: AppTextStyle.labelSmall_10,
                                        )
                                      : Text(
                                          NumUtils.formatInteger((listDatas
                                                  .elementAt(i)
                                                  .cFEEVALUE ??
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
            ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
