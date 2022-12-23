import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const int _kFlex = 1;
const Color _kBackgroundColor = Colors.white;
const bool _kAutoClose = true;

class CatalogSlidableAction extends SlidableAction {
  const CatalogSlidableAction({
    super.key,
    super.flex = _kFlex,
    super.backgroundColor = _kBackgroundColor,
    super.foregroundColor,
    super.autoClose = _kAutoClose,
    required super.onPressed,
    super.icon,
    super.spacing = 4,
    super.label,
    super.borderRadius = BorderRadius.zero,
    super.padding,
  });
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (icon != null) {
      children.add(
        Icon(icon),
      );
    }

    if (label != null) {
      if (children.isNotEmpty) {
        children.add(
          SizedBox(height: spacing),
        );
      }

      children.add(
        Text(
          label!,
          maxLines: 4,
          textAlign: TextAlign.center,
          // overflow: TextOverflow.ellipsis,
        ),
      );
    }

    final child = children.length == 1
        ? children.first
        : Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ...children.map(
                (child) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: child,
                    ),
                  ],
                ),
              )
            ],
          );

    return _CustomSlidableAction(
      borderRadius: borderRadius,
      padding: padding,
      onPressed: onPressed,
      autoClose: autoClose,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      flex: flex,
      child: child,
    );
  }
}

class _CustomSlidableAction extends CustomSlidableAction {
  const _CustomSlidableAction({
    super.flex = _kFlex,
    super.backgroundColor = _kBackgroundColor,
    super.foregroundColor,
    super.autoClose = _kAutoClose,
    super.borderRadius = BorderRadius.zero,
    super.padding,
    required super.onPressed,
    required super.child,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveForegroundColor = foregroundColor ??
        (ThemeData.estimateBrightnessForColor(backgroundColor) ==
                Brightness.light
            ? Colors.black
            : Colors.white);

    return Expanded(
      flex: flex,
      child: SizedBox.expand(
        child: InkWell(
          onTap: () => _handleTap(context),
          borderRadius: borderRadius,
          // style: OutlinedButton.styleFrom(
          //   padding: padding,
          //   backgroundColor: backgroundColor,
          //   foregroundColor: effectiveForegroundColor,
          //   disabledForegroundColor: effectiveForegroundColor,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: borderRadius,
          //   ),
          //   side: BorderSide.none,
          // ),
          child: Ink(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: backgroundColor,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    onPressed?.call(context);
    if (autoClose) {
      Slidable.of(context)?.close();
    }
  }
}
