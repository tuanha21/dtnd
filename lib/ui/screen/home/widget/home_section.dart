import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

import '../../../../config/service/app_services.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({
    super.key,
    required this.title,
    this.onMore,
    this.child,
    this.padding = 16,
    this.onTitleTap,
    this.onMoreDot,
  });
  final String title;
  final VoidCallback? onTitleTap;
  final VoidCallback? onMore;
  final VoidCallback? onMoreDot;
  final Widget? child;
  final double padding;
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onTitleTap,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              if (onMore != null)
                InkWell(
                  onTap: onMore,
                  child: Text(
                    S.of(context).see_more,
                    style: AppTextStyle.labelMedium_12
                        .copyWith(color: AppColors.primary_01),
                  ),
                )
              else if (onMoreDot != null)
                InkWell(
                  onTap: onMoreDot,
                  child: Icon(
                    Icons.more_horiz_rounded,
                    color: themeMode.isLight
                        ? AppColors.neutral_01
                        : AppColors.neutral_07,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        child ?? Container(),
      ],
    );
  }
}
