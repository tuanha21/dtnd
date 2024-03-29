import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_util.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_base/widget/home_base_nav.dart';

enum QuickAccess {
  money,
  baseTrading,
  virtualAssistant,
  custom,
  // derivative,
  // packEnrol,
  // bond,
  // coppytrade,
}

extension QuickAccessX on QuickAccess {
  String get path {
    switch (this) {
      case QuickAccess.money:
        return AppImages.home_icon_wallet_2;
      case QuickAccess.baseTrading:
        return AppImages.home_icon_chart_2;
      case QuickAccess.virtualAssistant:
        return AppImages.home_icon_cpu_charge;
      case QuickAccess.custom:
        return AppImages.home_icon_3dcube;
      // case QuickAccess.derivative:
      //   return AppImages.qa_derivative;
      // case QuickAccess.packEnrol:
      //   return AppImages.qa_pack_enrol;
      // case QuickAccess.bond:
      //   return AppImages.qa_bond;
      // case QuickAccess.virtualAssistant:
      //   return AppImages.qa_virtual_assistant;
    }
  }

  String name(BuildContext context) {
    switch (this) {
      case QuickAccess.money:
        return S.of(context).accumulate;
      case QuickAccess.baseTrading:
        return S.of(context).qa_base;
      case QuickAccess.virtualAssistant:
        return S.of(context).virtual_assistant;
      case QuickAccess.custom:
        return S.of(context).qa_custom;
      // case QuickAccess.derivative:
      //   return S.of(context).qa_derivative;
      // case QuickAccess.packEnrol:
      //   return S.of(context).qa_pack_enrol;
      // case QuickAccess.bond:
      //   return S.of(context).qa_bond;
      // case QuickAccess.virtualAssistant:
      //   return S.of(context).virtual_assistant;
    }
  }

  VoidCallback route(BuildContext context) {
    switch (this) {
      case QuickAccess.virtualAssistant:
        return () => VAUtil.toVirtualAssistantScreen(context);
      default:
        return () {};
    }
  }
}

class HomeQuickAccess extends StatefulWidget {
  const HomeQuickAccess(
      {super.key, required this.hasUser, required this.navigateTab});

  final bool hasUser;
  final ValueChanged<HomeNav> navigateTab;

  @override
  State<HomeQuickAccess> createState() => _HomeQuickAccessState();
}

class _HomeQuickAccessState extends State<HomeQuickAccess> {
  final AppService appService = AppService();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final themeMode = AppService.instance.themeMode.value;

    return LayoutBuilder(
      builder: (context, constrains) {
        // final int elementPerRow = constrains.maxWidth ~/ 80;
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: themeMode.isLight
                  ? AppColors.neutral_07
                  : AppColors.text_black_1,
            ),
            child: widget.hasUser
                ? Column(
                    children: [
                      Row(
                        children: [
                          Text(S.of(context).asset,
                              style: AppTextStyle.titleLarge_18.copyWith(
                                  color: themeData.colorScheme.onBackground)),
                          Expanded(child: Container()),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 4, bottom: 4, right: 12.5, left: 12.5),
                            decoration: BoxDecoration(
                              color: AppColors.accent_light_02,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Basic",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.titleSmall_14
                                  .copyWith(color: AppColors.graph_4),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      _AssetRow(widget.navigateTab),
                      // const Separator(
                      //   padding: EdgeInsets.symmetric(vertical: 16),
                      //   color: AppColors.neutral_05,
                      // ),
                      // for (int i = 0; i < QuickAccess.values.length; i += elementPerRow)
                      //   Row(
                      //     children: [
                      //       for (int j = 0; j < elementPerRow; j++)
                      //         if (i + j < QuickAccess.values.length)
                      //           Expanded(
                      //             child: Padding(
                      //               padding: EdgeInsets.only(left: j == 0 ? 0 : 16),
                      //               child: HomeQuickAccessElement(
                      //                   value: QuickAccess.values.elementAt(i + j)),
                      //             ),
                      //           )
                      //         else
                      //           Expanded(child: Container())
                      //     ],
                      //   ),
                    ],
                  )
                : GestureDetector(
                    onTap: () => {
                      Navigator.of(context).push<bool>(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),
                    },
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(S.of(context).login,
                                  style: AppTextStyle.titleLarge_18
                                      .copyWith(color: AppColors.primary_01)),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                S.of(context).connect_with_ifis,
                                maxLines: 2,
                              )
                            ],
                          ),
                        ),
                        // Expanded(child: SizedBox()),
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.text_black,
                          ),
                        ),
                      ],
                    ),
                  ));
      },
    );
  }
}

class _AssetRow extends StatefulWidget {
  const _AssetRow(this.navigateTab);

  final ValueChanged<HomeNav> navigateTab;

  @override
  State<_AssetRow> createState() => __AssetRowState();
}

class __AssetRowState extends State<_AssetRow> {
  final IUserService userService = UserService();
  bool show = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    show = !show;
                  });
                },
                child: Icon(
                  show
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: themeData.colorScheme.onBackground,
                )),
            const SizedBox(
              width: 16,
            ),
            show
                ? Obx(() {
                    final String data;
                    if (userService.totalAsset.value?.totalNav != null) {
                      data = NumUtils.formatInteger(
                          userService.totalAsset.value?.totalNav);
                    } else {
                      data = "-";
                    }
                    return Text(
                      "$datađ",
                      style:
                          TextStyle(color: themeData.colorScheme.onBackground),
                    );
                  })
                : Text("**********",
                    style: TextStyle(color: themeData.colorScheme.onBackground))
          ],
        ),
        GestureDetector(
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: themeData.colorScheme.onBackground,
          ),
          onTap: () {
            if (!userService.isLogin) {
              Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            } else {
              widget.navigateTab.call(HomeNav.asset);
            }
          },
        ),
      ],
    );
  }
}
