import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/ui/screen/community/widget/discover_widget/discover_screen.dart';
import 'package:dtnd/ui/screen/community/widget/post_widget.dart';
import 'package:dtnd/ui/screen/community/widget/premium_widget/premium_post_group.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/i_local_storage_service.dart';
import '../../../data/i_user_service.dart';
import '../../../data/implementations/local_storage_service.dart';
import '../../../data/implementations/user_service.dart';
import '../../theme/app_color.dart';
import '../market/widget/components/not_signin_catalog_widget.dart';
import 'community_controller.dart';

class CopyTradeTab extends StatefulWidget {
  const CopyTradeTab({Key? key}) : super(key: key);

  @override
  State<CopyTradeTab> createState() => _CopyTradeTabState();
}

class _CopyTradeTabState extends State<CopyTradeTab>
    with AutomaticKeepAliveClientMixin {
  final IUserService userService = UserService();
  final ILocalStorageService localStorageService = LocalStorageService();
  final CommunityController controller = CommunityController();

  void rebuild() => setState(() {
        initState();
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (userService.token.value == null) {
          return Center(
            child: NotSignInCatalogWidget(
              afterLogin: rebuild,
              localStorageService: localStorageService,
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Container(
              color: Colors.black12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.black12,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nhóm nổi bật",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DiscoverScreen(),
                                ));
                              },
                              child: Text(
                                "Xem tất cả",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.lightBlue,
                                    fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        alignment: Alignment.topCenter,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            topLeft: Radius.circular(8),
                                          ),
                                          child: Image.asset(
                                            AppImages.home_appbar_bg,
                                            alignment: Alignment.center,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 110),
                                        height: 36,
                                        width: 36,
                                        child: CachedNetworkImage(
                                          key: const ObjectKey(
                                              'https://nld.mediacdn.vn/291774122806476800/2022/10/20/hinh-0-1666238114349931972391.jpg'),
                                          imageUrl:
                                              "https://nld.mediacdn.vn/291774122806476800/2022/10/20/hinh-0-1666238114349931972391.jpg",
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Container(
                                            decoration: const BoxDecoration(
                                                color:
                                                    AppColors.accent_light_01,
                                                shape: BoxShape.circle),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                                  child: Icon(Icons.error)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Chứng khoán F0 (Mầm non chứng khoán)",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.group),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("841")
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text("+ Tham gia nhóm"),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    controller: controller.scrollController,
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < controller.posts.length) {
                        return PostWidget(
                          post: controller.posts.elementAt(index),
                        );
                      } else if (index == controller.posts.length &&
                          controller.loadingPosts.value) {
                        return _buildLoader();
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  const PremiumPostGroup(),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildLoader() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: const CircularProgressIndicator(),
    );
  }
}
