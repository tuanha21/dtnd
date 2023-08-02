import 'package:dtnd/ui/screen/home_base/widget/home_base_nav.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/bottom_sheet/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../config/service/app_services.dart';

class HomeBaseBottomNav extends StatefulWidget {
  const HomeBaseBottomNav({
    super.key,
    required this.currentHomeNav,
    this.onTapped,
  });

  final Rx<HomeNav> currentHomeNav;
  final ValueChanged<HomeNav>? onTapped;
  @override
  State<HomeBaseBottomNav> createState() => _HomeBaseBottomNavState();
}

class _HomeBaseBottomNavState extends State<HomeBaseBottomNav> {
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ObxValue<Rx<HomeNav>>(
        (currentHomeNav) {
          return FloatingBottomNavigationBar(
            currentIndex: currentHomeNav.value.index,
            // type: BottomNavigationBarType.shifting,
            showUnselectedLabels: false,
            items: [
              for (int index = 0; index < HomeNav.values.length; index++)
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    HomeNav.values[index].iconPath,
                  ),
                  activeIcon: SvgPicture.asset(
                    HomeNav.values[index].iconPath,
                    color: AppColors.primary_01,
                  ),
                  label: HomeNav.values[index].label(context),
                )
            ],
            onTap: (index) => widget.onTapped?.call(HomeNav.values[index]),
          );
        },
        widget.currentHomeNav,
      ),
    );
  }
}
