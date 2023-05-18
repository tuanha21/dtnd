import 'package:dtnd/=models=/response/top_signal_history_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../=models=/response/top_signal_detail_model.dart';
import '../../../../../theme/app_image.dart';

const List<String> _label = ["1W", "2W", "1M", "3M"];

class SignalTradingHistory extends StatefulWidget {
  const SignalTradingHistory({super.key, this.listHis,this.data,this.defaulPeriod,    required this.onChanged,});

  final List<TopSignalHistoryModel>? listHis;
  final TopSignalDetailModel? data;
  final String? defaulPeriod;
  final ValueChanged<ValuePerPeriod?>? onChanged;

  @override
  State<SignalTradingHistory> createState() => _SignalTradingHistoryState();
}

class _SignalTradingHistoryState extends State<SignalTradingHistory> {
  late List<ValuePerPeriod> periods;
  ValuePerPeriod? selectedPeriod;

  @override
  void initState() {
    super.initState();
    generateData();
  }

  void generateData() {
    if (widget.data == null) {
      periods = List.generate(4, (index) => ValuePerPeriod.defaultVal());
    } else {
      periods = widget.data!.clist;
    }
    if (widget.defaulPeriod != null) {
      final period = periods
          .firstWhereOrNull((element) => element.label == widget.defaulPeriod);
      if (period != null) {
        selectedPeriod = period;
      }
    } else {
      selectedPeriod = periods[2];
    }
  }

  void onChanged(ValuePerPeriod? period) {
    if (period != selectedPeriod) {
      setState(() {
        selectedPeriod = period;
      });
      widget.onChanged?.call(selectedPeriod);
    }
  }

  @override
  void didUpdateWidget(covariant SignalTradingHistory oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data?.cSHARECODE != widget.data?.cSHARECODE) {
      generateData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              for (int i = 0; i < _label.length; i++)
                Expanded(
                  child: _Figure(
                    selected: selectedPeriod == periods.elementAt(i),
                    data: periods.elementAt(i),
                    onChanged: onChanged,
                  ),
                )
            ],
          ),
          const SizedBox(height: 8,),
          const Divider(
            thickness: 1,
            color: AppColors.neutral_04,
            indent: 16,
            endIndent: 16,
          ),
          if (widget.listHis?.isEmpty ?? true)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: EmptyListWidget(
                title: "BOT chưa có lịch sử giao dịch",
              ),
            )
          else
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.listHis!.length,
              itemBuilder: (context, index) {
                final his = widget.listHis!.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: SignalTradingHistoryElement(
                    pc: his.pc,
                    buy: his.buyPrice,
                    sell: his.sellPrice,
                    buyTime: his.buyDateString,
                    sellTime: his.sellDateString,
                    icon: his.prefixIcon(),
                    color: his.color,
                    risk: his.volatility,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class SignalTradingHistoryElement extends StatelessWidget {
  const SignalTradingHistoryElement({
    super.key,
    required this.icon,
    required this.color,
    required this.pc,
    required this.buy,
    required this.sell,
    required this.buyTime,
    required this.sellTime,
    this.risk,
  });
  final num? pc;
  final num? buy;
  final num? sell;
  final num? risk;
  final String? buyTime;
  final String? sellTime;
  final Widget icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        color: Colors.white,
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  S.of(context).profit_value,
                  style: AppTextStyle.labelSmall_10.copyWith(
                      color: AppColors.neutral_04, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 5),
                SizedBox.square(
                  dimension: 14,
                  child: icon,
                ),
                const SizedBox(width: 5),
                Text(
                  "$pc%",
                  style: AppTextStyle.titleSmall_14.copyWith(color: color),
                ),
              ],
            ),
            SizedBox(
              height: 20,
              child: Row(
                children: [
                  Text(
                    "Giá mua/bán",
                    style: AppTextStyle.labelSmall_10.copyWith(
                        color: AppColors.neutral_04,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${buy ?? "-"}",
                    style: AppTextStyle.titleSmall_14
                        .copyWith(color: AppColors.semantic_01),
                  ),
                  const VerticalDivider(
                    width: 10,
                    thickness: 2,
                  ),
                  Text(
                    "${sell ?? "-"}",
                    style: AppTextStyle.titleSmall_14
                        .copyWith(color: AppColors.semantic_03),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).buy_date,
                    style: AppTextStyle.labelSmall_10.copyWith(
                        color: AppColors.neutral_04,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    buyTime ?? "-",
                    style: AppTextStyle.labelSmall_10,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  S.of(context).risk,
                  style: AppTextStyle.labelSmall_10.copyWith(
                      color: AppColors.neutral_04, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  "${risk ?? "-"}%",
                  style: AppTextStyle.labelSmall_10,
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).sell_date,
                    style: AppTextStyle.labelSmall_10.copyWith(
                        color: AppColors.neutral_04,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    sellTime ?? "-",
                    style: AppTextStyle.labelSmall_10,
                  ),
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure({required this.data, this.onChanged, required this.selected});

  final ValuePerPeriod data;
  final bool selected;
  final ValueChanged<ValuePerPeriod?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final String path;
    final Color color;
    final Color bgColor;
    switch (data.per.compareTo(0)) {
      case 1:
        path = AppImages.prefix_up_icon2;
        color = AppColors.semantic_01;
        bgColor = AppColors.accent_light_01;
        break;
      case -1:
        path = AppImages.prefix_down_icon2;
        color = AppColors.semantic_03;
        bgColor = AppColors.accent_light_03;
        break;
      default:
        path = AppImages.prefix_ref_icon;
        color = AppColors.semantic_02;
        bgColor = AppColors.accent_light_02;
        break;
    }
    final Widget icon = Image.asset(
      path,
    );
    return Column(
      children: [
        Text(
          data.label,
          style:
          AppTextStyle.labelMedium_12.copyWith(color: AppColors.neutral_04),
        ),
        const SizedBox(height: 4),
        Material(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: InkWell(
            onTap: () => onChanged?.call(data),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: bgColor,
                border:
                selected ? Border.all(color: AppColors.neutral_04) : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox.square(
                    dimension: 10,
                    child: icon,
                  ),
                  const SizedBox(width: 3),
                  Flexible(
                    child: Text(
                      "${data.per}%",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.labelMedium_12
                          .copyWith(fontWeight: FontWeight.w600, color: color),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
