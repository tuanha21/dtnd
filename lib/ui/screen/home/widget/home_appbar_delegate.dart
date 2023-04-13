import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/widget/home_quick_access.dart';
import 'package:dtnd/ui/screen/search/search_screen.dart';
import 'package:dtnd/ui/screen/stock_detail/stock_detail_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

const imageHeight = 280.0;

class HomeAppbarDelegate extends SliverPersistentHeaderDelegate {
  const HomeAppbarDelegate(
      this.appService, this.dataCenterService, this.userService);

  final AppService appService;
  final IDataCenterService dataCenterService;
  final IUserService userService;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    final ratio = 1 - (shrinkOffset / _difference);
    Widget title = Obx(() {
      String textTitle;
      Widget avatar;
      if (userService.userInfo.value != null) {
        textTitle = userService.userInfo.value!.customerName ?? "Kien Nguyen";
        if (userService.userInfo.value!.faceImg != null) {
          avatar = Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: CachedNetworkImage(
              imageUrl: "${userService.userInfo.value!.faceImg}",
              fit: BoxFit.fill,
            ),
          );
        } else {
          avatar = ClipOval(
            child: Image.asset(
              AppImages.home_avatar_default,
              width: 40, // adjust the width as needed
              height: 40, // adjust the height as needed
              fit: BoxFit.cover,
            ),
          );
        }
      } else {
        textTitle = "IFIS";
        avatar = Image.asset(
          AppImages.logo_account_default,
          width: 32,
          height: 32,
          fit: BoxFit.fill,
        );
      }
      if (userService.userInfo.value != null) {}
      return GestureDetector(
        onTap: () => Scaffold.of(context).openDrawer(),
        child: Row(
          children: [
            avatar,
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userService.userInfo.value != null
                    ? Text(
                        textAlign: TextAlign.left,
                        S.of(context).hello,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                      )
                    : const SizedBox(),
                Text(
                  textTitle,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ],
        ),
      );
    });
    return Material(
      child: Stack(
        children: [
          Positioned(
            top: shrinkOffset / _difference * -imageHeight,
            child: SizedBox(
              width: size.width,
              height: imageHeight,
              child: _HomeBanner(appService),
            ),
          ),
          // Positioned(
          //   top: 234 + (shrinkOffset / _difference * -imageHeight),
          //   left: 16,
          //   child: SizedBox(
          //     width: size.width - 32,
          //     child: const HomeQuickAccess(),
          //   ),
          // ),

          Positioned(
            bottom: 20,
            left: ratio <= 0 ? 0 : 16,
            child: SizedBox(
              width: ratio <= 0 ? size.width : size.width - 32,
              child: HomeQuickAccess(
                hasUser: userService.userInfo.value != null,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 120,
              child: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  decoration: ratio <= 0
                      ? const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.linear_01, AppColors.linear_02],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        )
                      : const BoxDecoration(),
                ),
                backgroundColor:
                    ratio <= 0 ? AppColors.primary_01 : Colors.transparent,
                title: title,
                actions: [
                  SizedBox.square(
                    dimension: 24,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ))
                            .then((value) async {
                          if (value is Stock) {
                            dataCenterService.getStocksModelsFromStockCodes(
                                [value.stockCode]).then((stockModels) {
                              if (stockModels != null) {
                                return Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => StockDetailScreen(
                                    stockModel: stockModels.first,
                                  ),
                                ));
                              }
                            });
                          }
                        });
                      },
                      child: Image.asset(
                        AppImages.home_icon_search_normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox.square(
                      dimension: 32,
                      child: Image.asset(
                        AppImages.home_icon_notification,
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double get _difference => maxExtent - minExtent;

  @override
  double get maxExtent => 350;

  @override
  double get minExtent => userService.userInfo.value == null ? 233 : 188;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _HomeBanner extends StatefulWidget {
  const _HomeBanner(this.appService);
  final AppService appService;
  @override
  State<_HomeBanner> createState() => __HomeBannerState();
}

class __HomeBannerState extends State<_HomeBanner> {
  @override
  void initState() {
    super.initState();
    widget.appService.getHomeBanner(NetworkService());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.appService.loadingHomBanner.value) {
        return const Center(
          child: SizedBox.square(
            dimension: 40,
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (widget.appService.homeBanner == null) {
        return Image.asset(
          AppImages.home_appbar_bg,
          fit: BoxFit.fill,
        );
      }
      return CarouselSlider.builder(
        itemCount: widget.appService.homeBanner?.length,
        itemBuilder: (context, index, _) {
          return (widget.appService.homeBanner != null)
              ? Image.network(
                  widget.appService.homeBanner?[index].img ?? '',
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                )
              : Image.asset(
                  AppImages.home_appbar_bg,
                  fit: BoxFit.fill,
                );
        },
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
          height: 400,
        ),
      );
    });
  }
}
