import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/ui/screen/home/widget/home_appbar.dart';
import 'package:dtnd/ui/screen/home/widget/home_quick_access.dart';
import 'package:dtnd/ui/screen/search/search_screen.dart';
import 'package:dtnd/ui/screen/stock_detail/stock_detail_screen.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

const imageHeight = 280.0;

class HomeAppbarDelegate extends SliverPersistentHeaderDelegate {
  const HomeAppbarDelegate(this.appService, this.dataCenterService);
  final AppService appService;
  final IDataCenterService dataCenterService;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
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
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 80,
              child: HomeAppBar(
                backgroundColor: Colors.transparent,
                title: "DTND",
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
                                dataCenterService.getStockModelsFromStockCodes([
                                  value.stockCode
                                ]).then((stockModels) => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => StockDetailScreen(
                                        stockModel: stockModels.first,
                                      ),
                                    )));
                              }
                            });
                          },
                          child:
                              Image.asset(AppImages.home_icon_search_normal))),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox.square(
                      dimension: 24,
                      child: Image.asset(AppImages.home_icon_notification)),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
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