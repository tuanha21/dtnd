import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:flutter/material.dart';

abstract class ISheet {
  const ISheet();
  Future<void>? onResultBack([UserCmd? cmd]);
  Future<void>? onResultNext([UserCmd? cmd]);
  Widget? backWidget([UserCmd? cmd]);
  Widget? nextWidget([UserCmd? cmd]);
  ISheet? back([UserCmd? cmd]);
  ISheet? next([UserCmd? cmd]);

  Future<UserCmd?> showSheet(BuildContext context, Widget? child) {
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

  Future<UserCmd?> cmd(BuildContext context, UserCmd? cmd) {
    print(cmd);
    if (cmd is BackCmd) {
      return onResultBack.call(cmd)?.then((_) =>
              back.call(cmd)?.showSheet(context, backWidget.call(cmd))) ??
          back.call(cmd)?.showSheet(context, backWidget.call(cmd)) ??
          Future(
            () => null,
          );
    } else if (cmd is NextCmd) {
      return onResultNext.call(cmd)?.then((_) =>
              next.call(cmd)?.showSheet(context, nextWidget.call(cmd))) ??
          next.call(cmd)?.showSheet(context, nextWidget.call(cmd)) ??
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
    return Future(() {
      return cmd;
    });
  }
}
