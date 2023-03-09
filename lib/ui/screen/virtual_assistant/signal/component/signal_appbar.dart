import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class SignalAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SignalAppbar({
    super.key,
    required this.stock,
    this.onTap,
  });

  final VoidCallback? onTap;
  final Stock stock;

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 48,
      leading: Align(
        alignment: Alignment.centerRight,
        child: SizedBox.square(
          dimension: 32,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: Ink(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: themeMode.isLight
                      ? AppColors.neutral_05
                      : AppColors.neutral_01,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.primary_01,
                  size: 10,
                ),
              ),
            ),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: stock.stockCode,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w700)),
                const TextSpan(text: " "),
                TextSpan(
                  text: "(${stock.postTo?.name})",
                  style: AppTextStyle.labelLarge_18
                      .copyWith(color: AppColors.neutral_03),
                ),
              ],
            ),
          ),
          Text(
            "${stock.nameShort}",
            style: AppTextStyle.bottomNavLabel
                .copyWith(color: AppColors.neutral_03),
          ),
        ],
      ),
    );
  }

  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
