import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/widget/quick_access_element.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_controller.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_register/virtual_assistant_register.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_screen.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_util.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

enum QuickAccess {
  money,
  base,
  derivative,
  packEnrol,
  bond,
  coppytrade,
  virtualAssistant,
}

extension QuickAccessX on QuickAccess {
  String get path {
    switch (this) {
      case QuickAccess.money:
        return AppImages.qa_money;
      case QuickAccess.base:
        return AppImages.qa_base;
      case QuickAccess.derivative:
        return AppImages.qa_derivative;
      case QuickAccess.packEnrol:
        return AppImages.qa_pack_enrol;
      case QuickAccess.bond:
        return AppImages.qa_bond;
      case QuickAccess.coppytrade:
        return AppImages.qa_copytrade;
      case QuickAccess.virtualAssistant:
        return AppImages.qa_virtual_assistant;
    }
  }

  String name(BuildContext context) {
    switch (this) {
      case QuickAccess.money:
        return S.of(context).qa_money;
      case QuickAccess.base:
        return S.of(context).qa_base;
      case QuickAccess.derivative:
        return S.of(context).qa_derivative;
      case QuickAccess.packEnrol:
        return S.of(context).qa_pack_enrol;
      case QuickAccess.bond:
        return S.of(context).qa_bond;
      case QuickAccess.coppytrade:
        return S.of(context).qa_copytrade;
      case QuickAccess.virtualAssistant:
        return S.of(context).virtual_assistant;
    }
  }

  HomeQuickAccessElementTheme get theme {
    switch (this) {
      case QuickAccess.money:
        return HomeQuickAccessElementTheme.purple;
      case QuickAccess.base:
        return HomeQuickAccessElementTheme.blue;
      case QuickAccess.derivative:
        return HomeQuickAccessElementTheme.orange;
      case QuickAccess.packEnrol:
        return HomeQuickAccessElementTheme.green;
      case QuickAccess.bond:
        return HomeQuickAccessElementTheme.green;
      case QuickAccess.coppytrade:
        return HomeQuickAccessElementTheme.orange;
      case QuickAccess.virtualAssistant:
        return HomeQuickAccessElementTheme.purple;
    }
  }

  VoidCallback route(BuildContext context) {
    switch (this) {
      case QuickAccess.virtualAssistant:
        return () => VirtualAsisstantUtil.toVirtualAssistantScreen(context);
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
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      runAlignment: WrapAlignment.spaceBetween,
      children: [
        for (QuickAccess element in QuickAccess.values)
          HomeQuickAccessElement(value: element)
      ],
    );
  }
}
