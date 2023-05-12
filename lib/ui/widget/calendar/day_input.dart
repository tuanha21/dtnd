import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/sheet/i_table_calendar_sheet.dart';
import 'package:dtnd/ui/widget/sheet/table_calendar_sheet.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';

class DayInput extends StatefulWidget {
  const DayInput({
    super.key,
    required this.initialDay,
    required this.firstDay,
    required this.lastDay,
    this.onChanged,
    this.color,
  });

  final DateTime initialDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final ValueChanged<DateTime>? onChanged;
  final Color? color;

  @override
  State<DayInput> createState() => _DayInputState();
}

class _DayInputState extends State<DayInput> {
  late DateTime currentDateTime;

  @override
  void initState() {
    super.initState();
    currentDateTime = widget.initialDay;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: InkWell(
        onTap: () => TableCalendarISheet()
            .show(
                context,
                TableCalendarSheet(
                  firstDay: widget.firstDay,
                  lastDay: widget.lastDay,
                  focusedDay: currentDateTime,
                ))
            .then((value) {
          if (value?.data != null) {
            setState(() {
              currentDateTime = value?.data;
            });
            widget.onChanged?.call(value?.data);
          } else {
            return;
          }
        }),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: widget.color ?? AppColors.neutral_06,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            children: [
              Text(
                TimeUtilities.commonTimeFormat.format(widget.initialDay),
                style: textTheme.labelMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(width: (widget.color != null) ? 50 : 34),
              SizedBox.square(
                dimension: 15,
                child: Image.asset(AppImages.calendar_2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
