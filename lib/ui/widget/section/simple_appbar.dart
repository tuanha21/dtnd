import 'package:dtnd/ui/widget/icon/back_button.dart';
import 'package:flutter/material.dart';

class SimpleAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppbar({
    super.key,
    required this.title,
    this.actions,
  });
  final String title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SheetBackButton(
        onTap: () {},
      ),
      title: Text(title),
      titleTextStyle: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(fontWeight: FontWeight.w700),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
