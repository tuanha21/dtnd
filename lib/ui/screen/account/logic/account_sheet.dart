import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:flutter/material.dart';

class MoneyStatementISheet extends ISheet {
  const MoneyStatementISheet();

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([UserCmd? cmd]) {
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

class ShareStatementISheet extends ISheet {
  const ShareStatementISheet();

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([UserCmd? cmd]) {
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
