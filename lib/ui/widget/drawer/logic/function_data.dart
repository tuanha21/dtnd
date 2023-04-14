class FunctionData {
  final String title;
  final String? iconPath;
  final Function? function;
  final List<String>? subTitle;
  late bool isExpanded;

  FunctionData(
      {required this.title,
      this.function,
      required this.subTitle,
      this.iconPath,
      this.isExpanded = false});
}
