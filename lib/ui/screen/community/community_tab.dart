import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/community/sheet/community_posts_sheet.dart';
import 'package:dtnd/ui/screen/community/widget/read_more_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../data/i_network_service.dart';
import '../../../data/i_user_service.dart';
import '../../theme/app_color.dart';
import '../../theme/app_image.dart';
import '../market/widget/components/not_signin_catalog_widget.dart';
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

  void rebuild() => setState(() {
        initState();
      });

  @override
  void initState() {
    controller.scrollController.addListener(controller.scrollListener);
    controller.init();
    super.initState();
  }

  @override
  void dispose() {
    controller.scrollController.removeListener(controller.scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    super.build(context);
    return Scaffold(
      body: Obx(
        () {
          if (userService.token.value == null) {
            return Center(
              child: NotSignInCatalogWidget(
                afterLogin: rebuild,
                localStorageService: localStorageService,
              ),
            );
          } else {
            if (controller.posts.isEmpty && controller.loadingPosts.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: themeData.colorScheme.background),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.local_fire_department,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Đáng chú ý",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          rowStatus("Ngoài quỹ mới UIKO trước đó có",
                              "Nguyễn Phúc Thức", context),
                          rowStatus(
                              "GEG điểm mua thứ nhất 13.900 - 14.100 / điểm....",
                              "Nguyễn Gia Vinh",
                              context),
                          const Text("#AAM"),
                          rowStatus(
                              "Cho hỏi sao anfin mới 11h đã thông báo giờ đóng cửa",
                              "Hồ Gia Bảo",
                              context),
                          rowStatus(
                              "VNIDEX tuần sau", "Nguyễn Quốc Dũng", context),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ReadMoreScreen(),
                              ));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Xem thêm ",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                Icon(
                                  Icons.arrow_right_alt_sharp,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: themeData.colorScheme.background,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.stars_rounded),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Nhà sáng tạo nổi bật",
                                style: TextStyle(
                                    color: themeData.colorScheme.onBackground,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Theo dõi và ủng hộ nội dung của những nhà sáng tạo hàng đầu",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                featuredCreator(context),
                                featuredCreator(context),
                                featuredCreator(context),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      controller: controller.scrollController,
                      shrinkWrap: true,
                      itemCount: controller.posts.length,
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
                  ],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: userService.isLogin
          ? Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: SizedBox.square(
                dimension: 50,
                child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: InkWell(
                    onTap: _onFABTapped,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: SvgPicture.asset(
                        AppImages.icon_pencil,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  void _onFABTapped() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CommunityPostsSheet(),
      ),
    );

    // CommunityPostsISheet().show(context, const CommunityPostsSheet()).then(
    //   (value) {
    //     if (value?.data != '') {
    //       controller.getPosts();
    //     }
    //   },
    // );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget _buildLoader() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: const CircularProgressIndicator(),
  );
}

Widget rowStatus(String status, String userName, BuildContext context) {
  final ThemeData themeData = Theme.of(context);
  return Container(
    margin: const EdgeInsets.only(bottom: 5),
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          status,
          style: TextStyle(
              fontSize: 14, color: themeData.colorScheme.onBackground),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 36,
              width: 36,
              child: CachedNetworkImage(
                key: const ObjectKey(
                    'https://nld.mediacdn.vn/291774122806476800/2022/10/20/hinh-0-1666238114349931972391.jpg'),
                imageUrl:
                    "https://nld.mediacdn.vn/291774122806476800/2022/10/20/hinh-0-1666238114349931972391.jpg",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => Container(
                  decoration: const BoxDecoration(
                      color: AppColors.accent_light_01, shape: BoxShape.circle),
                ),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              userName,
              style: TextStyle(
                  color: themeData.colorScheme.onBackground, fontSize: 14),
            )
          ],
        ),
      ],
    ),
  );
}

Widget featuredCreator(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(right: 10),
    width: MediaQuery.of(context).size.width / 2,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center,
              height: 36,
              width: 36,
              child: CachedNetworkImage(
                key: const ObjectKey(
                    'https://nld.mediacdn.vn/291774122806476800/2022/10/20/hinh-0-1666238114349931972391.jpg'),
                imageUrl:
                    "https://nld.mediacdn.vn/291774122806476800/2022/10/20/hinh-0-1666238114349931972391.jpg",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => Container(
                  decoration: const BoxDecoration(
                      color: AppColors.accent_light_01, shape: BoxShape.circle),
                ),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8)),
              child: const Column(
                children: [
                  Text(
                    "3.832",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  Text(
                    "tương tác",
                    style: TextStyle(color: Colors.grey, fontSize: 8),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("Nguyễn Mạnh Đông"),
        const SizedBox(
          height: 30,
        )
      ],
    ),
  );
}
