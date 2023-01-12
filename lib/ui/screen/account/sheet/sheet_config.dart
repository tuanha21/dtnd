import 'package:dtnd/=models=/ui_model/overlay.dart';
import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:flutter/material.dart';

class UserInfoDetailISheet extends ISheet {
  const UserInfoDetailISheet();
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
