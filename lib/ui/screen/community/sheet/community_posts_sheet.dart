import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/ui/screen/community/community_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../data/i_user_service.dart';
import '../../../../data/implementations/user_service.dart';

class CommunityPostsSheet extends StatefulWidget {
  const CommunityPostsSheet({
    super.key,
  });

  @override
  State<CommunityPostsSheet> createState() => _CommunityPostsSheetState();
}

class _CommunityPostsSheetState extends State<CommunityPostsSheet>
    with SingleTickerProviderStateMixin {
  final IUserService userService = UserService();
  final CommunityController controller = CommunityController();
  TextEditingController postsController = TextEditingController();
  int postLength = 0;

  @override
  void initState() {
    super.initState();
    postsController.addListener(_updatePostLength);
  }

  @override
  void dispose() {
    postsController.removeListener(_updatePostLength);
    postsController.dispose();
    super.dispose();
  }

  void _updatePostLength() {
    setState(() {
      postLength = postsController.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget title = Obx(() {
      String textTitle;
      String subTitle;
      Widget avatar;
      if (userService.userInfo.value != null) {
        textTitle = userService.userInfo.value!.customerName ?? "Kien Nguyen";
        subTitle = userService.userInfo.value!.custEmail ?? "ifis@gmail.com";
        if (userService.userInfo.value!.faceImg != null) {
          avatar = Container(
            width: 36,
            height: 36,
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
              width: 36, // adjust the width as needed
              height: 36, // adjust the height as needed
              fit: BoxFit.cover,
            ),
          );
        }
      } else {
        textTitle = "IFIS";
        subTitle = "ifis@gmail.com";
        avatar = Image.asset(
          AppImages.logo_account_default,
          width: 22,
          height: 22,
          fit: BoxFit.fill,
        );
      }
      if (userService.userInfo.value != null) {}
      return Row(
        children: [
          avatar,
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textTitle,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text_black_1,
                    ),
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.graph_5,
                    ),
              ),
            ],
          ),
        ],
      );
    });

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: SvgPicture.asset(
                  AppImages.back_draw_icon,
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              Text(
                'Tạo bài viết',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text_black_1,
                    ),
              ),
              TextButton(
                  onPressed: () {
                    if (postsController.text != '') {
                      controller.postPosts(postsController.text).then((value) {
                        if (value) {
                          EasyLoading.showToast('Tạo bài viết thành công');
                          Navigator.of(context).pop();
                        } else {
                          EasyLoading.showToast(
                              'Tạo bài viết thất bại, hãy thử lại');
                        }
                      });
                    } else {
                      EasyLoading.showToast('Hãy nhập nội dung bài đăng');
                    }
                  },
                  child: const Text('Đăng'))
            ],
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title,
              Text(
                '$postLength/1000',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.graph_5,
                    ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: TextField(
              maxLengthEnforcement: MaxLengthEnforcement.none,
              maxLength: 1000,
              controller: postsController,
              decoration: const InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText:
                    'Chia sẻ suy nghĩ của bạn hoặc đặt câu hỏi cho cộng đồng',
              ),
              maxLines: null,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Chọn chủ đề bài đăng (0/3)',
                textAlign: TextAlign.start,
              ),
            ],
          )
        ],
      ),
    ));
  }
}
