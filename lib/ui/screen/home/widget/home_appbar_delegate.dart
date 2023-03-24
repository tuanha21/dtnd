import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/ui/screen/home/widget/home_quick_access.dart';
import 'package:dtnd/ui/screen/search/search_screen.dart';
import 'package:dtnd/ui/screen/stock_detail/stock_detail_screen.dart';
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
        textTitle = userService.userInfo.value!.custFullName ?? "";
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
          avatar = const SizedBox.square(
            dimension: 40,
            child: Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
            ),
          );
        }
      } else {
        textTitle = "DTND";
        avatar = SizedBox.square(
          dimension: 36,
          child: Icon(
            Icons.account_circle_rounded,
            color: ratio <= 0 ? Colors.black : Colors.white,
          ),
        );
      }
      if (userService.userInfo.value != null) {}
      return Row(
        children: [
          avatar,
          const SizedBox(width: 8),
          Text(
            textTitle,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ratio <= 0 ? Colors.black : Colors.white,
                ),
          ),
        ],
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
          Positioned(
            top: 224 + (shrinkOffset / _difference * -imageHeight),
            left: 16,
            child: SizedBox(
              width: size.width - 32,
              child: const HomeQuickAccess(),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 80,
              child: AppBar(
                backgroundColor: ratio <= 0 ? Colors.white : Colors.transparent,
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
                            dataCenterService.getStockModelsFromStockCodes(
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
                        color: ratio <= 0 ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox.square(
                      dimension: 24,
                      child: Image.asset(
                        AppImages.home_icon_notification,
                        color: ratio <= 0 ? Colors.black : Colors.white,
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
  double get maxExtent => 400;

  @override
  double get minExtent => 80;

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
      if (widget.appService.homeBanner.value == null) {
        return Image.asset(
          AppImages.home_appbar_bg,
          fit: BoxFit.fill,
        );
      }
      return Image.network(
        widget.appService.homeBanner.value!,
        fit: BoxFit.fill,
      );
    });
  }
}
