import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({
    super.key,
    required this.title,
    this.onMore,
    this.child,
    this.padding = 16,
  });
  final String title;
  final VoidCallback? onMore;
  final Widget? child;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              onMore != null
                  ? InkWell(
                      onTap: onMore,
                      child: Text(
                        S.of(context).see_more,
                        style: AppTextStyle.labelMedium_12
                            .copyWith(color: AppColors.primary_01),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        const SizedBox(height: 16),
        child ?? Container(),
      ],
    );
  }
}
