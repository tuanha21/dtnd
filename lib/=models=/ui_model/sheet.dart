import 'package:dtnd/=models=/ui_model/overlay.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:flutter/material.dart';

abstract class ISheet implements IOverlay {
  const ISheet();
  @override
  Future<UserCmd?> show(BuildContext context, Widget? child) {
    if (child == null) {
      return Future(
        () => null,
      );
    }
    return showModalBottomSheet<UserCmd>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            // TechnicalTradings(
            //   onChoosen: (value) => Navigator.of(context).pop(value),
            // ),
            child
          ],
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
