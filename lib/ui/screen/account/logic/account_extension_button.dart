import 'package:flutter/material.dart';

abstract class IAccountExtensionButton {
  IAccountExtensionButton({
    required this.icon,
    required this.label,
  });
  String icon;
  String label;
  late ValueChanged<BuildContext> onPress;
}

class StockAccountExtensionButton extends IAccountExtensionButton {
  StockAccountExtensionButton({required super.icon, required super.label});
}
