import 'package:dtnd/=models=/response/top_signal_detail_model.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const List<String> _label = ["1W", "2W", "1M", "3M"];

class SignalEffective extends StatefulWidget {
  const SignalEffective(
      {super.key, this.data, required this.onChanged, this.defaulPeriod});
  final TopSignalDetailModel? data;
  final ValueChanged<ValuePerPeriod?>? onChanged;
  final String? defaulPeriod;
  @override
  State<SignalEffective> createState() => _SignalEffectiveState();
}

class _SignalEffectiveState extends State<SignalEffective> {
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
  void didUpdateWidget(covariant SignalEffective oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data?.cSHARECODE != widget.data?.cSHARECODE) {
      generateData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox.square(
                  dimension: 36, child: Image.asset(AppImages.signal_icon)),
              const SizedBox(width: 12),
              Text(
                "Hiệu quả",
                style: AppTextStyle.titleSmall_14
                    .copyWith(color: AppColors.primary_01),
              )
            ],
          ),
          const SizedBox(height: 12),
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
          )
        ],
      ),
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
