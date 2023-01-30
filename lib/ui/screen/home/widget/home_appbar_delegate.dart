import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/screen/home/widget/home_appbar.dart';
import 'package:dtnd/ui/screen/home/widget/home_quick_access.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppbarDelegate extends SliverPersistentHeaderDelegate {
  const HomeAppbarDelegate(this.appService);
  final AppService appService;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final themeMode = appService.themeMode;
    final scrollRatio = 1 - (shrinkOffset / _difference);
    final size = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: [
          Positioned(
            top: shrinkOffset / _difference * -250,
            child: SizedBox(
              width: size.width,
              height: 250,
              child: Image.asset(
                AppImages.home_appbar_bg,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 80,
              child: HomeAppBar(
                backgroundColor: Colors.transparent,
                title: "DTND",
                actions: [
                  SvgPicture.asset(AppImages.search_appbar_icon),
                  const SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset(AppImages.notification_appbar_icon),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 224 + (shrinkOffset / _difference * -250),
            left: 16,
            child: SizedBox(
              width: size.width - 32,
              child: HomeQuickAccess(),
            ),
          ),
        ],
      ),
    );
  }

  double get _difference => maxExtent - minExtent;

  @override
  double get maxExtent => 400;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
