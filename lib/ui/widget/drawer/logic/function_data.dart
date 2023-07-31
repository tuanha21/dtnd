class FunctionData {
  final String title;
  final String? iconPath;
  final Function? function;
  final List<FunctionData>? subTitle;
  late bool isExpanded;

  FunctionData(
      {required this.title,
      this.function,
       this.subTitle,
      this.iconPath,
      this.isExpanded = false});
}
