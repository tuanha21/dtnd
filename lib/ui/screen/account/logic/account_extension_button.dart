import 'package:dtnd/generated/l10n.dart';
import 'package:flutter/material.dart';

class AccountExtensionButton {
  AccountExtensionButton({
    required this.icon,
    required this.label,
    this.route,
  });
  String icon;
  String label;
  Widget? route;
  bool sameType(Object? o) => o.runtimeType == runtimeType;
}
