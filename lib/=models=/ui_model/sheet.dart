import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:flutter/material.dart';

abstract class ISheet {
  const ISheet();
  Future<void>? onResultBack([dynamic data]);
  Future<void>? onResultNext([dynamic data]);
  Widget? backWidget([dynamic data]);
  Widget? nextWidget([dynamic data]);
  ISheet? back([dynamic data]);
  ISheet? next([dynamic data]);

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
    if (cmd is BackCmd) {
      return onResultBack.call(cmd.data)?.then((_) => back
              .call(cmd.data)
              ?.showSheet(context, backWidget.call(cmd.data))) ??
          back.call(cmd.data)?.showSheet(context, backWidget.call(cmd.data)) ??
          Future(
            () => null,
          );
    }
    if (cmd is NextCmd) {
      return onResultNext.call(cmd.data)?.then((_) => next
              .call(cmd.data)
              ?.showSheet(context, nextWidget.call(cmd.data))) ??
          next.call(cmd.data)?.showSheet(context, nextWidget.call(cmd.data)) ??
          Future(
            () => null,
          );
    }
    // if (cmd is ToOptionCmd) {
    //   for (var element in options!) {
    //     if (element.runtimeType == cmd.data.runtimeType) {
    //       return toOption(element, cmd.data)!.showSheet(context);
    //     }
    //   }
    // }
    return Future(() {
      return null;
    });
  }
}
