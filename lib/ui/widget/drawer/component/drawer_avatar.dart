import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/account_info_model.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

class DrawerAvatar extends StatefulWidget {
  const DrawerAvatar({super.key, this.imageUrl, this.info});
  final String? imageUrl;
  final UserInfo? info;
  @override
  State<DrawerAvatar> createState() => _DrawerAvatarState();
}

class _DrawerAvatarState extends State<DrawerAvatar> {
  @override
  Widget build(BuildContext context) {
    final Widget avatar;
    if (widget.imageUrl != null) {
      avatar = CachedNetworkImage(
        imageUrl: widget.imageUrl!,
      );
    } else {
      avatar = Container(
        padding: const EdgeInsets.all(4),
        width: 80,
        height: 80,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: const Icon(
          Icons.account_circle_outlined,
          color: AppColors.neutral_03,
          size: 72,
        ),
      );
    }
    return Stack(
      children: <Widget>[
        // Avatar widget with size of 80
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey[300],
          child: avatar,
        ),
        // Camera icon button overlay at the bottom right corner
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset(AppImages.drawer_camera_icon),
            ),
          ),
        )
      ],
    );
  }
}
