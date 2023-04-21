import 'package:flutter/material.dart';
import 'i_appbar.dart';

class SimpleAppbar extends IAppbar {
  const SimpleAppbar({
    super.key,
    required this.title,
    this.actions,
  });
  final String title;
  final List<Widget>? actions;

  @override
  Widget titleBuilder(BuildContext context) => Text(title);

  @override
  List<Widget>? actionsBuilder(BuildContext context) => actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleBuilder(context),
      titleTextStyle: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(fontWeight: FontWeight.w700),
      actions: actionsBuilder(context),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
