import 'package:dtnd/utilities/regex.dart';
import 'package:flutter/material.dart';

extension StringX on String {
  bool get isNum => numRegex.hasMatch(this);

  bool get isOrderType => orderTypeRegex.hasMatch(this);
}

Size calculateTextSize({
  required String text,
  required TextStyle style,
  BuildContext? context,
}) {
  final double textScaleFactor = context != null
      ? MediaQuery.of(context).textScaleFactor
      : WidgetsBinding.instance.window.textScaleFactor;

  final TextDirection textDirection =
      context != null ? Directionality.of(context) : TextDirection.ltr;

  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: textDirection,
    textScaleFactor: textScaleFactor,
  )..layout(minWidth: 0, maxWidth: double.infinity);

  return textPainter.size;
}
