import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: [
        SvgPicture.asset(AppImages.search_appbar_icon),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(AppImages.notification_appbar_icon),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }
}
