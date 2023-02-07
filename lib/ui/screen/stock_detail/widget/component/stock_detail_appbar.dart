import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/stock_detail_overview.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/svg_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../=models=/local/local_catalog.dart';
import '../../../market/widget/components/user_catalog_widget.dart';
import '../../sheet/AddStockCatalog.dart';

final appbarPaddingTop = WidgetsBinding.instance.window.viewPadding.top /
    WidgetsBinding.instance.window.devicePixelRatio;

class StockDetailAppbar extends SliverPersistentHeaderDelegate {
  StockDetailAppbar({
    required this.stockModel,
    this.onTap,
  });

  final VoidCallback? onTap;
  final StockModel stockModel;

  void addCatalog(BuildContext context) async {
    var res = await AddCatalogISheet().show(context, const AddCatalogSheet());
    if (res is BackCmd) {
      var localCatalog = res.data as LocalCatalog;
      if (context.mounted) {
        await showCupertinoModalBottomSheet(
            context: context,
            builder: (_) => BottomAddStock(localCatalog: localCatalog));
        if (context.mounted) {
          addCatalog(context);
        }
      }
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scrollRatio = 1 - (shrinkOffset / _difference);
    final themeMode = AppService.instance.themeMode.value;
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: AppBar(
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
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
            title: GestureDetector(
              onTap: onTap,
              child: Column(
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
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: scrollRatio,
            child: SizedBox(
              height: 64,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StockDetailOverview(stockModel: stockModel),
              ),
            ),
          ),
        )
      ],
    );
  }

  double get _difference => maxExtent - minExtent;

  @override
  double get maxExtent => minExtent + 80;

  @override
  double get minExtent => appbarPaddingTop + kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
