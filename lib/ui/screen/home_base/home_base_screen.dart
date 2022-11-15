import 'package:dtnd/ui/screen/home_base/widget/home_base_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBase extends StatefulWidget {
  const HomeBase({super.key});

  @override
  State<HomeBase> createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    key: homeBaseKey,
    body: ,
    );
  }
}

class OffStageNavigator extends StatelessWidget {
  const OffStageNavigator({super.key, required this.homeNav, required this.currentHomeNav,});
  final HomeNav homeNav;
  final Rx<HomeNav> currentHomeNav;
  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<HomeNav>>(
       (context) {
        return Offstage(
          offstage: currentHomeNav.value != homeNav,
        );
      },currentHomeNav,
    );
  }
}
