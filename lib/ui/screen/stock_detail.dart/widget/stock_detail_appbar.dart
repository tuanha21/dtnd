import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/svg_icon_button.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:flutter/material.dart';

class StockDetailAppbar extends StatefulWidget implements PreferredSizeWidget {
  const StockDetailAppbar({
    Key? key,
    required this.stock,
  }) : super(key: key);
  final Stock stock;

  @override
  State<StockDetailAppbar> createState() => _StockDetailAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _StockDetailAppbarState extends State<StockDetailAppbar> {
  final AppService appService = AppService();
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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: widget.stock.stockCode,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w700)),
                const TextSpan(text: " "),
                TextSpan(
                  text: "(${widget.stock.postTo?.name})",
                  style: AppTextStyle.labelLarge_18
                      .copyWith(color: AppColors.neutral_03),
                ),
              ],
            ),
          ),
          Text(
            "${widget.stock.nameShort}",
            style: AppTextStyle.bottomNavLabel
                .copyWith(color: AppColors.neutral_03),
          ),
        ],
      ),
      actions: [
        SvgIconButton(
          AppImages.search_appbar_icon,
          onPressed: () {},
          iconSize: 20,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        SvgIconButton(
          AppImages.notification_appbar_icon,
          onPressed: () {},
          iconSize: 20,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }
}
