import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home_base/widget/home_base_nav.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_color.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    this.title,
    this.leading,
    this.titleWidget,
    this.actions,
    this.backgroundColor,
  });

  final String? title;
  final Widget? leading;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Color? backgroundColor;
  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  final IUserService userService = UserService();
  late List<Widget>? _actions;

  @override
  void initState() {
    _actions = widget.actions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget title;
    if (widget.titleWidget != null) {
      title = widget.titleWidget!;
    } else if (widget.title != null) {
      title = Text(
        widget.title!,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
      );
    } else {
      title = Obx(() {
        String textTitle;
        Widget avatar;
        if (userService.userInfo.value != null) {
          textTitle = userService.userInfo.value!.customerName ?? "";
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
          avatar = Image.asset(
            AppImages.logo_account_default,
            width: 22,
            height: 22,
            fit: BoxFit.fill,
          );
        }
        if (userService.userInfo.value != null) {}
        return GestureDetector(
          onTap: homeBaseKey.currentState!.openDrawer,
          child: Row(
            children: [
              avatar,
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userService.userInfo.value != null
                      ? Text(
                          '${S.of(context).hello} 👋',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                        )
                      : Container(),
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
    }
    return AppBar(
      flexibleSpace: Container(
          decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.linear_01, AppColors.linear_02],
        ),
      )),
      leading: widget.leading,
      title: title,
      actions: _actions,
      backgroundColor: widget.backgroundColor,
    );
  }
}
