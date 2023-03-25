import 'package:dtnd/=models=/ui_model/overlay.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:flutter/material.dart';

abstract class ISheet implements IOverlay {
  const ISheet();
  @override
  Future<UserCmd?> show(BuildContext ctx, Widget? child, {bool wrap = true}) {
    if (child == null) {
      return Future(
        () => null,
      );
    }
    Widget content = wrap
        ? Wrap(
            children: [child],
          )
        : SizedBox(
            height:
                MediaQuery.of(ctx).size.height - MediaQuery.of(ctx).padding.top,
            child: child);
    // print(MediaQuery.of(context).size.height);
    // print(MediaQuery.of(context).padding.top);
    return showModalBottomSheet<UserCmd>(
      context: ctx,
      isScrollControlled: true,
      // useSafeArea: true,
      // enableDrag: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: content,
        );
      },
    ).then((result) => cmd(ctx, result));
  }

  @override
  Future<UserCmd?> cmd(BuildContext context, UserCmd? cmd) {
    if (cmd is BackCmd) {
      return onResultBack.call(cmd)?.then(
              (_) => back.call(cmd)?.show(context, backWidget.call(cmd))) ??
          back.call(cmd)?.show(context, backWidget.call(cmd)) ??
          Future(
            () => cmd,
          );
    } else {
      return onResultNext.call(cmd)?.then(
              (_) => next.call(cmd)?.show(context, nextWidget.call(cmd))) ??
          next.call(cmd)?.show(context, nextWidget.call(cmd)) ??
          Future(
            () => cmd,
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
