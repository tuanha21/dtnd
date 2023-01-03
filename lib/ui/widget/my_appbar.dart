import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/service/app_services.dart';
import '../theme/app_color.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.title,
    this.leading,
    this.titleWidget,
    this.actions,
  });

  final String title;
  final Widget? leading;
  final Widget? titleWidget;
  final List<Widget>? actions;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  late List<Widget>? _actions;

  @override
  void initState() {
    _actions = widget.actions;
    super.initState();
  }

  Widget? get backButton {
    final themeMode = AppService.instance.themeMode.value;

    if(Navigator.canPop(context)){
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            child: Ink(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius:
                const BorderRadius.all(Radius.circular(6)),
                color: themeMode.isLight
                    ? AppColors.neutral_05
                    : AppColors.neutral_01,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.primary_01,
                size: 13,
              ),
            ),
          ),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.leading ?? backButton,
      title: widget.titleWidget ??
          Text(
            widget.title,
            style: Theme
                .of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
      actions: _actions,
    );
  }
}
