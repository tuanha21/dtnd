import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatefulWidget {
  const CustomTableCalendar({
    super.key,
    required this.focusedDay,
    required this.firstDay,
    required this.lastDay,
    this.onChanged,
  });

  final DateTime? focusedDay;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final ValueChanged<DateTime>? onChanged;
  @override
  State<CustomTableCalendar> createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  late DateTime _now;
  late DateTime _firstDay;
  late DateTime _lastDay;
  @override
  void initState() {
    _now = widget.focusedDay ?? DateTime.now();
    _firstDay = widget.firstDay ?? _now.firstDayOfMonth;
    _lastDay = widget.lastDay ?? _now.lastDayOfMonth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: AppColors.neutral_06),
      child: TableCalendar(
        firstDay: _firstDay,
        lastDay: _lastDay,
        focusedDay: DateTime.now(),
        // selectedDayPredicate: (day) {
        //   return isSameDay(_selectedDay, day);
        // },
        onDaySelected: (selectedDay, focusedDay) {
          return widget.onChanged?.call(selectedDay);
        },
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            final String dayOfWeek;
            switch (day.weekday) {
              case DateTime.sunday:
                dayOfWeek = "CN";
                break;
              case DateTime.monday:
                dayOfWeek = "T2";
                break;
              case DateTime.tuesday:
                dayOfWeek = "T3";
                break;
              case DateTime.wednesday:
                dayOfWeek = "T4";
                break;
              case DateTime.thursday:
                dayOfWeek = "T5";
                break;
              case DateTime.friday:
                dayOfWeek = "T6";
                break;
              case DateTime.saturday:
                dayOfWeek = "T7";
                break;
              default:
                throw Exception();
            }
            return Center(
              child: Text(
                dayOfWeek,
                style: AppTextStyle.titleSmall_14
                    .copyWith(color: AppColors.primary_01),
              ),
            );
          },
        ),
      ),
    );
  }
}
