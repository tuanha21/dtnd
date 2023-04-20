import 'package:dtnd/=models=/ui_model/overlay.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:flutter/material.dart';

abstract class IDialog implements IOverlay {
  const IDialog({this.barrierDismissible = true});
  final bool barrierDismissible;

  @override
  Future<UserCmd?> show(BuildContext context, Widget? child) async {
    if (child == null) {
      return null;
    }
    return showDialog<UserCmd>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: child,
        );
      },
    ).then((result) {
      if (result == null) {
        try {
          return onTapOutside(context);
        } catch (e) {
          return Future.value(null);
        }
      }
      return cmd(context, result);
    });
  }

  @override
  Future<UserCmd?> cmd(BuildContext context, UserCmd userCmd) {
    if (userCmd is BackCmd) {
      return onResultBack.call(userCmd)?.then((_) =>
              back.call(userCmd)?.show(context, backWidget.call(userCmd))) ??
          back.call(userCmd)?.show(context, backWidget.call(userCmd)) ??
          Future.value(null);
    } else {
      return onResultNext.call(userCmd)?.then((_) =>
              next.call(userCmd)?.show(context, nextWidget.call(userCmd))) ??
          next.call(userCmd)?.show(context, nextWidget.call(userCmd)) ??
          Future.value(null);
    }
  }

  @override
  Future<UserCmd?> onTapOutside(BuildContext context) {
    throw Exception();
  }
}
