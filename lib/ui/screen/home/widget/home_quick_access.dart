import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/widget/quick_access_element.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_util.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/seperator.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum QuickAccess {
  money,
  base,
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
      case QuickAccess.base:
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
      case QuickAccess.base:
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
  const HomeQuickAccess({super.key});

  @override
  State<HomeQuickAccess> createState() => _HomeQuickAccessState();
}

class _HomeQuickAccessState extends State<HomeQuickAccess> {
  final AppService appService = AppService();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final int elementPerRow = constrains.maxWidth ~/ 80;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            for (int i = 0; i < QuickAccess.values.length; i += elementPerRow)
              Row(
                children: [
                  for (int j = 0; j < elementPerRow; j++)
                    if (i + j < QuickAccess.values.length)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: j == 0 ? 0 : 16),
                          child: HomeQuickAccessElement(
                              value: QuickAccess.values.elementAt(i + j)),
                        ),
                      )
                    else
                      Expanded(child: Container())
                ],
              ),
            const Separator(
              padding: EdgeInsets.symmetric(vertical: 16),
              color: AppColors.neutral_05,
            ),
            const _AssetRow()
          ],
        ),
      );
    });
  }
}

class _AssetRow extends StatefulWidget {
  const _AssetRow();

  @override
  State<_AssetRow> createState() => __AssetRowState();
}

class __AssetRowState extends State<_AssetRow> {
  final IUserService userService = UserService();
  bool show = false;
  @override
  Widget build(BuildContext context) {
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
                  color: AppColors.text_black,
                )),
            const SizedBox(
              width: 16,
            ),
            show
                ? Obx(() {
                    final String data;
                    if (userService.totalAsset.value?.totalEnquity != null) {
                      data = NumUtils.formatInteger(
                          userService.totalAsset.value?.totalEnquity);
                    } else {
                      data = "-";
                    }
                    return Text("$datađ");
                  })
                : Text("**********")
          ],
        ),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.text_black,
        ),
      ],
    );
  }
}
