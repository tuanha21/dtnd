import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
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
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  late List<Widget>? _actions;

  @override
  void initState() {
    _actions = widget.actions;
    super.initState();
  }

  Widget? get backButton {
    if (Navigator.canPop(context)) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            child: Ink(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: AppColors.neutral_05,
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

  Widget? get title {
    return widget.titleWidget ??
        Text(
          widget.title ?? "DTND",
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.leading ?? backButton,
      title: title,
      actions: _actions,
      backgroundColor: widget.backgroundColor,
    );
  }
}
