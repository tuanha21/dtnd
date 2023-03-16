import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/svg_icon_button.dart';
import 'package:flutter/material.dart';
import '../../sheet/AddStockCatalog.dart';

class StockDetailAppbar extends StatelessWidget implements PreferredSizeWidget {
  const StockDetailAppbar({
    super.key,
    required this.stockModel,
    this.onTap,
    required this.isChart,
  });

  final VoidCallback? onTap;
  final StockModel stockModel;
  final bool isChart;

  void addCatalog(BuildContext context) async {
    await AddCatalogISheet(stock: stockModel.stock.stockCode)
        .show(context, AddCatalogSheet(stock: stockModel.stock.stockCode));
  }

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
                    text: stockModel.stock.stockCode,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w700)),
                const TextSpan(text: " "),
                TextSpan(
                  text: "(${stockModel.stock.postTo?.name})",
                  style: AppTextStyle.labelLarge_18
                      .copyWith(color: AppColors.neutral_03),
                ),
              ],
            ),
          ),
          Text(
            "${stockModel.stock.nameShort}",
            style: AppTextStyle.bottomNavLabel
                .copyWith(color: AppColors.neutral_03),
          ),
        ],
      ),
      actions: [
        SvgIconButton(
          AppImages.add_square,
          onPressed: () {
            addCatalog(context);
          },
          iconSize: 20,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        GestureDetector(
          onTap: onTap,
          child: Image.asset(
            AppImages.chart,
            height: 24,
            width: 24,
            color: isChart
                ? Theme.of(context).colorScheme.onPrimary
                : AppColors.neutral_03,
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
