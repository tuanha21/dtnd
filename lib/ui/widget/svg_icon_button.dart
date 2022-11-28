import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIconButton extends StatelessWidget {
  const SvgIconButton(
    this.asset, {
    super.key,
    this.onPressed,
    this.iconSize,
    this.color,
    this.bgColor,
  });
  final String asset;
  final VoidCallback? onPressed;
  final double? iconSize;
  final Color? color;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final double? splashRadius = iconSize == null ? null : (iconSize! * 1.2);
    return IconButton(
      padding: const EdgeInsets.all(0),
      iconSize: iconSize,
      splashRadius: splashRadius,
      onPressed: onPressed,
      color: bgColor,
      hoverColor: bgColor,
      icon: SvgPicture.asset(
        asset,
        color: color,
      ),
    );
  }
}
