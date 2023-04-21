import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:flutter/material.dart';

abstract class IOverlay {
  Future<void>? onResultBack([UserCmd? cmd]);
  Future<void>? onResultNext([UserCmd? cmd]);
  Widget? backWidget([UserCmd? cmd]);
  Widget? nextWidget([UserCmd? cmd]);
  IOverlay? back([UserCmd? cmd]);
  IOverlay? next([UserCmd? cmd]);
  Future<UserCmd?> show(BuildContext context, Widget? child);

  Future<UserCmd?> cmd(BuildContext context, UserCmd cmd);
  Future<UserCmd?> onTapOutside(BuildContext context);
}
