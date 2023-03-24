import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/ui/widget/sheet/i_table_calendar_sheet.dart';
import 'package:flutter/material.dart';

class MoneyStatementISheet extends ISheet {
  MoneyStatementISheet();

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([UserCmd? cmd]) {
    if (cmd is ToOptionCmd) {
      return TableCalendarISheet();
    }
    return null;
  }

  @override
  Widget? backWidget([cmd]) => null;

  @override
  Widget? nextWidget([UserCmd? cmd]) {
    return null;
  }

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
}
