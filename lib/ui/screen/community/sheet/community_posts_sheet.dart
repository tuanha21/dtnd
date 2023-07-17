import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/generated/l10n.dart';
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
    controller.clearImage();
    super.dispose();
  }

  void _updatePostLength() {
    setState(() {
      postLength = postsController.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Obx(
      () {
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
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
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
                    S.of(context).create_a_post,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text_black_1,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (postsController.text != '') {
                        controller.postPosts(postsController.text).then(
                          (value) {
                            if (value) {
                              EasyLoading.showToast(
                                  S.of(context).post_created_successfully);
                              Navigator.of(context).pop();
                            } else {
                              EasyLoading.showToast(
                                  S.of(context).post_creation_failed);
                            }
                          },
                        );
                      } else {
                        EasyLoading.showToast(
                            S.of(context).please_enter_the_content_of_the_post);
                      }
                    },
                    child: Text(S.of(context).post),
                  )
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
              Expanded(
                child: SizedBox(
                  child: TextField(
                    maxLengthEnforcement: MaxLengthEnforcement.none,
                    maxLength: 1000,
                    controller: postsController,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: S.of(context).share_your_thoughts,
                    ),
                    maxLines: null,
                  ),
                ),
              ),
              Obx(() {
                final image = controller.image.value;
                return (image != null)
                    ? Image.file(image)
                    : const SizedBox();
              }),
              const SizedBox(height: 10,),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${S.of(context).choose_the_topic}(0/3)',
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "Diễn biến thị trường",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "Tín hiệu đầu tư",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "Giải trí",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Icon(Icons.add_circle)),
                  InkWell(
                    onTap: (){
                      controller.takePicture();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      // chọn ảnh
                      controller.pickImage();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Icon(
                        Icons.image,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(
                      Icons.gif,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
