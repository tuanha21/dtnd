import 'package:dtnd/ui/screen/home_base/widget/home_base_nav.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
    return ObxValue<Rx<HomeNav>>(
      (currentHomeNav) {
        return BottomNavigationBar(
          currentIndex: currentHomeNav.value.index,
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
    );
  }
}
