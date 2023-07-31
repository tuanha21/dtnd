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
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: themeData.colorScheme.background),
      child: TableCalendar(
        firstDay: _firstDay,
        lastDay: _lastDay,
        focusedDay: _now,
        currentDay: _now,
        // selectedDayPredicate: (day) {
        //   return isSameDay(_selectedDay, day);
        // },

        daysOfWeekHeight: 32,
        headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            formatButtonShowsNext: false,
            decoration: BoxDecoration(
                border: BorderDirectional(
                    bottom: BorderSide(color: AppColors.neutral_05)))),
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
            return Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                dayOfWeek,
                style: AppTextStyle.titleSmall_14
                    .copyWith(color: AppColors.primary_01),
              ),
            );
          },
          todayBuilder: (context, day, focusedDay) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: AppColors.primary_01,
              ),
              child: Text(
                focusedDay.day.toString(),
                style: AppTextStyle.bodyMedium_14.copyWith(color: Colors.white),
              ),
            );
          },
          defaultBuilder: (context, day, focusedDay) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              // decoration: const BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(8)),
              //   color: AppColors.primary_01,
              // ),
              child: Text(
                day.day.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          },
          outsideBuilder: (context, day, focusedDay) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              // decoration: const BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(8)),
              //   color: AppColors.primary_01,
              // ),
              child: Text(
                day.day.toString(),
                maxLines: 1,
                style: AppTextStyle.bodyMedium_14
                    .copyWith(color: AppColors.neutral_04),
              ),
            );
          },
          headerTitleBuilder: (context, day) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "T${day.month} ${day.year}",
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
