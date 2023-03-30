class FunctionData {
  final String title;
  final String? iconPath;
  final Function? function;
  final List<FunctionData>? subFunction;

  const FunctionData(
      {required this.title, this.function, this.subFunction, this.iconPath});
}
