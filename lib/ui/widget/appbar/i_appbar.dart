import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

abstract class IAppbar extends StatelessWidget implements PreferredSizeWidget {
  const IAppbar({super.key});
  Widget titleBuilder(BuildContext context);

  List<Widget>? actionsBuilder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 48,
      leading: Align(
        alignment: Alignment.centerRight,
        child: SizedBox.square(
          dimension: 32,
          child: Material(
            color: themeMode.isLight
                ? AppColors.neutral_05
                : AppColors.neutral_01,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: Ink(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: themeMode.isLight
                      ? AppColors.neutral_05
                      : AppColors.neutral_01,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.primary_01,
                  size: 10,
                ),
              ),
            ),
          ),
        ),
      ),
      title: titleBuilder(context),
      actions: actionsBuilder(context),
    );
  }

  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
