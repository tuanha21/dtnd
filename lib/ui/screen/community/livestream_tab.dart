import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/i_local_storage_service.dart';
import '../../../data/i_user_service.dart';
import '../../../data/implementations/local_storage_service.dart';
import '../../../data/implementations/user_service.dart';
import '../../theme/app_color.dart';
import '../market/widget/components/not_signin_catalog_widget.dart';

class LiveStreamTab extends StatefulWidget {
  const LiveStreamTab({Key? key}) : super(key: key);

  @override
  State<LiveStreamTab> createState() => _LiveStreamTabState();
}

class _LiveStreamTabState extends State<LiveStreamTab>
    with AutomaticKeepAliveClientMixin {
  final IUserService userService = UserService();
  final ILocalStorageService localStorageService = LocalStorageService();

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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.play_circle),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Xem lại"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  itemLiveStream(),
                  itemLiveStream(),
                  itemLiveStream(),
                  itemLiveStream(),
                  itemLiveStream()
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget itemLiveStream() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.lightBlue.shade200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("06/07/2023 - 20:02 PM"),
                Row(
                  children: [Text("15 người tham gia")],
                )
              ],
            ),
          ),
          const Text(
            "Thị trường tiếp tục giằng co, dòng tiền như nào ??",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
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
                        color: AppColors.accent_light_01,
                        shape: BoxShape.circle),
                  ),
                  errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text("Nguyễn Phúc Thức")
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Dòng tiền chảy ở trạng thái khác"),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Phí: 9.000đ")
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.centerRight,
                child: const Text(
                  "Xem ngay",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
