import 'package:dtnd/=models=/ui_model/overlay.dart';
import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:flutter/src/widgets/framework.dart';

class VaOrderSheet extends ISheet {
  @override
  IOverlay? back([UserCmd? cmd]) {
    // TODO: implement back
    throw UnimplementedError();
  }

  @override
  Widget? backWidget([UserCmd? cmd]) {
    // TODO: implement backWidget
    throw UnimplementedError();
  }

  @override
  IOverlay? next([UserCmd? cmd]) {
    throw UnimplementedError();
  }

  @override
  Widget? nextWidget([UserCmd? cmd]) {
    // TODO: implement nextWidget
    throw UnimplementedError();
  }

  @override
  Future<void>? onResultBack([UserCmd? cmd]) {
    // TODO: implement onResultBack
    throw UnimplementedError();
  }

  @override
  Future<void>? onResultNext([UserCmd? cmd]) {
    // TODO: implement onResultNext
    throw UnimplementedError();
  }
}
