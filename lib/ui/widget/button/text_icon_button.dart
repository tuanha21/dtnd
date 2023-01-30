import 'package:dtnd/generated/l10n.dart';
import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    Key? key,
    required this.icon,
    required this.label,
    this.size = 20.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    this.onTap,
  }) : super(key: key);
  final String icon;
  final String label;
  final double size;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap ?? () {},
        child: Ink(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: size,
                height: size,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                overflow: TextOverflow.ellipsis,
                style:
                    textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
