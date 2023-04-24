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
        return SingleChildScrollView(
          child: content
        );
      },
    ).then((result) {
      if (result == null) {
        try {
          return onTapOutside(ctx);
        } catch (e) {
          return Future.value(null);
        }
      }
      return cmd(ctx, result);
    });
  }

  @override
  Future<UserCmd?> cmd(BuildContext context, UserCmd cmd) {
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
  }

  @override
  Future<UserCmd?> onTapOutside(BuildContext context) {
    throw Exception();
  }
}
