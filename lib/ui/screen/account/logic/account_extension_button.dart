class AccountExtensionButton {
  AccountExtensionButton({
    required this.icon,
    required this.label,
    this.route,
  });
  String icon;
  String label;
  dynamic route;
  bool sameType(Object? o) => o.runtimeType == runtimeType;
}
