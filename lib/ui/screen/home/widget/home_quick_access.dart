import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/widget/quick_access_element.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_util.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

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
        return S.of(context).qa_money;
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
  @override
  Widget build(BuildContext context) {
    final int elementPerRow = MediaQuery.of(context).size.width ~/ 80;
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
            )
        ],
      ),
    );
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      alignment: WrapAlignment.spaceBetween,
      runAlignment: WrapAlignment.spaceBetween,
      children: [
        for (QuickAccess element in QuickAccess.values)
          HomeQuickAccessElement(value: element)
      ],
    );
  }
}
