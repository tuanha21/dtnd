import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../theme/app_color.dart';
import '../../../../theme/app_image.dart';

const imageHeight = 130.0;

class InfoAppBarDelegate extends SliverPersistentHeaderDelegate {
  bool isImageVisible = true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    final isScrolledToTop = shrinkOffset <= 0;
    final opacity = 1.0 - (shrinkOffset / _difference);
    const opacity2 = 1.0 - 0;

    return Material(
      child: Stack(
        children: [
          Positioned(
            top: shrinkOffset / _difference * -imageHeight / 10,
            child: Container(
              color: Colors.blue,
              width: size.width,
              height: imageHeight,
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedOpacity(
                      opacity: isScrolledToTop ? 0.0 : opacity2,
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeInOut,
                      child: const Text(
                        "Nguyễn Mạnh Đông",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _showBottomSheetMore(context);
                    },
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 20,
            child: SizedBox(
              height: Platform.isAndroid
                  ? 85 * (size.height / (812 / 3.5))
                  : 100 * (size.height / (812 / 2.2)),
              child: AnimatedOpacity(
                opacity: isScrolledToTop ? opacity : 0.0,
                duration: const Duration(milliseconds: 900),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  alignment: Alignment.center,
                  height: 72,
                  width: 72,
                  child: CachedNetworkImage(
                    key: const ObjectKey(
                      'https://nld.mediacdn.vn/291774122806476800/2022/10/20/hinh-0-1666238114349931972391.jpg',
                    ),
                    imageUrl:
                        'https://nld.mediacdn.vn/291774122806476800/2022/10/20/hinh-0-1666238114349931972391.jpg',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      decoration: const BoxDecoration(
                        color: AppColors.accent_light_01,
                        shape: BoxShape.circle,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double get _difference => maxExtent - minExtent;

  @override
  double get maxExtent => 165;

  @override
  double get minExtent {
    if (Platform.isAndroid) {
      return 85;
    } else {
      return 85;
    }
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;

  void _showBottomSheetMore(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.front_hand),
                title: const Text('Chặn '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Báo cáo'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HomeBanner extends StatefulWidget {
  const _HomeBanner();

  @override
  State<_HomeBanner> createState() => __HomeBannerState();
}

class __HomeBannerState extends State<_HomeBanner> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Image.asset(
        AppImages.home_appbar_bg,
        fit: BoxFit.fill,
      );
    });
  }
}
