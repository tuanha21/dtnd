import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/ui/widget/calendar/custom_table_calendar.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';

class TableCalendarSheet extends StatefulWidget {
  const TableCalendarSheet({
    super.key,
    required this.focusedDay,
    required this.firstDay,
    required this.lastDay,
  });

  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;

  @override
  State<TableCalendarSheet> createState() => _TableCalendarSheetState();
}

class _TableCalendarSheetState extends State<TableCalendarSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetHeader(
              title: "Thời gian tùy chỉnh",
              backData: null,
            ),
            CustomTableCalendar(
              firstDay: widget.firstDay,
              lastDay: widget.lastDay,
              focusedDay: widget.focusedDay,
              onChanged: (day) => Navigator.of(context).pop(BackCmd(day)),
            ),
          ],
        ),
      ),
    );
  }
}
