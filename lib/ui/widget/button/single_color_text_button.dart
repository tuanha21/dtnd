import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class SingleColorTextButton extends StatelessWidget {
  const SingleColorTextButton({
    super.key,
    required this.text,
    required this.color,
    this.textStyle,
    this.onTap,
  });
  final String text;
  final Color color;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 12),
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
