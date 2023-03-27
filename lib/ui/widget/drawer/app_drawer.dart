import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final IUserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    bool isLogin = userService.isLogin;
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      width: 275,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.all(4),
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: const Icon(
              Icons.account_circle_outlined,
              color: AppColors.neutral_03,
              size: 72,
            ),
          ),
          Text(
            userService.token.value?.name ?? "Khách",
            style: AppTextStyle.labelLarge_18.copyWith(
                color: AppColors.primary_01, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
