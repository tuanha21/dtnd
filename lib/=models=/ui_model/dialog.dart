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
          insetPadding: const EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        );
      },
    ).then((result) => cmd(context, result));
  }

  @override
  Future<UserCmd?> cmd(BuildContext context, UserCmd? cmd) {
    print(cmd);
    if (cmd is BackCmd) {
      return onResultBack.call(cmd)?.then(
              (_) => back.call(cmd)?.show(context, backWidget.call(cmd))) ??
          back.call(cmd)?.show(context, backWidget.call(cmd)) ??
          Future(
            () => null,
          );
    } else {
      return onResultNext.call(cmd)?.then(
              (_) => next.call(cmd)?.show(context, nextWidget.call(cmd))) ??
          next.call(cmd)?.show(context, nextWidget.call(cmd)) ??
          Future(
            () => null,
          );
    }
    // if (cmd is ToOptionCmd) {
    //   for (var element in options!) {
    //     if (element.runtimeType == cmd.runtimeType) {
    //       return toOption(element, cmd)!.showSheet(context);
    //     }
    //   }
    // }
  }
}
