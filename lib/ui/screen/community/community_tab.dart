import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/community/sheet/community_posts_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../data/i_network_service.dart';
import '../../../data/i_user_service.dart';
import '../../theme/app_image.dart';
import 'business/comunity_post_flow.dart';
import 'community_controller.dart';
import 'widget/post_widget.dart';

class CommunityTab extends StatefulWidget {
  const CommunityTab({Key? key}) : super(key: key);

  @override
  State<CommunityTab> createState() => _CommunityTabState();
}

class _CommunityTabState extends State<CommunityTab>
    with AutomaticKeepAliveClientMixin {
  final CommunityController controller = CommunityController();
  final IUserService userService = UserService();
  final INetworkService networkService = NetworkService();
  final ILocalStorageService localStorageService = LocalStorageService();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            if (controller.loadingPosts.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.separated(
              itemCount: controller.posts.length,
              itemBuilder: (BuildContext context, int index) {
                return PostWidget(
                  post: controller.posts.elementAt(index),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 16,
                );
              },
            );
          }),
        ),
        floatingActionButton: userService.isLogin
            ? Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: SizedBox.square(
                  dimension: 40,
                  child: Material(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      onTap: _onFABTapped,
                      child: Ink(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: SvgPicture.asset(
                          AppImages.add_square,
                        ),
                        // child: SvgPicture.asset(
                        //   AppImages.arrange_circle,
                        // ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox());
  }

  void _onFABTapped() async {
    CommunityPostsISheet()
        .show(context, const CommunityPostsSheet())
        .then((value) {
      controller.getPosts();
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   super.build(context);
  //   var bodyLarge = Theme.of(context).textTheme.bodyLarge;
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const StockWidget(),
  //         const SizedBox(height: 16),
  //         ListView.separated(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemBuilder: (context, index) {
  //               if (index == 0) {
  //                 return const PostWidget();
  //               }
  //               return const PostWidget(
  //                 chart: Padding(
  //                   padding: EdgeInsets.only(bottom: 16),
  //                   child: LineChartSample2(),
  //                 ),
  //               );
  //             },
  //             separatorBuilder: (context, index) {
  //               return const SizedBox(height: 16);
  //             },
  //             itemCount: 2),
  //         const SizedBox(height: 16),
  //         Text(
  //           '🔥 HOT',
  //           style: bodyLarge?.copyWith(fontWeight: FontWeight.w700),
  //         ),
  //         const SizedBox(height: 16),
  //         ListView.separated(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemBuilder: (context, index) {
  //               return const StockWidgetChart();
  //             },
  //             separatorBuilder: (context, index) {
  //               return const SizedBox(height: 8);
  //             },
  //             itemCount: 3),
  //         const SizedBox(height: 100),
  //       ],
  //     ),
  //   );
  // }

  @override
  bool get wantKeepAlive => true;
}
