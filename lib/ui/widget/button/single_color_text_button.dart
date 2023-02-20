import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class SingleColorTextButton extends StatelessWidget {
  const SingleColorTextButton({
    super.key,
    required this.text,
    required this.color,
    this.textStyle,
    this.onTap,
    this.padding,
  });
  final String text;
  final Color color;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Ink(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Center(
              child: Text(
                text,
                style: textStyle ??
                    AppTextStyle.titleSmall_14.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          )),
    );
  }
}
