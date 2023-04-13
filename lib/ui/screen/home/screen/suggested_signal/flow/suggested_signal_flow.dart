import 'package:dtnd/=models=/ui_model/overlay.dart';
import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';

class SuggestedSignalISheet extends ISheet {
  @override
  IOverlay? back([UserCmd? cmd]) => null;

  @override
  Widget? backWidget([UserCmd? cmd]) => null;

  @override
  IOverlay? next([UserCmd? cmd]) => null;

  @override
  Widget? nextWidget([UserCmd? cmd]) => null;

  @override
  Future<void>? onResultBack([UserCmd? cmd]) => null;

  @override
  Future<void>? onResultNext([UserCmd? cmd]) => null;
}
