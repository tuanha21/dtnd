import 'package:dtnd/=models=/ui_model/overlay.dart';
import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:flutter/material.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';

class ExtensionsISheet extends ISheet {
  const ExtensionsISheet();
  @override
  IOverlay? back([cmd]) => null;

  @override
  Widget? backWidget([cmd]) => null;

  @override
  IOverlay? next([cmd]) => null;

  @override
  Widget? nextWidget([cmd]) => null;

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
}

class ToBaseNoteCmd extends ToOptionCmd {
  const ToBaseNoteCmd([super.data]);
}

class ToProfitAndLossCmd extends ToOptionCmd {
  const ToProfitAndLossCmd([super.data]);
}
