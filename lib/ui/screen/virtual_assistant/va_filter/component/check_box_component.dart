import 'package:flutter/material.dart';

import '../../../../theme/app_color.dart';

typedef OpTapCheckBox = Function(String value, bool isSelect);


class CheckBoxComponent extends StatefulWidget {
  final bool? initValue;
  final String text;
  final String? initText;
  final OpTapCheckBox onChanged;

  const CheckBoxComponent(
      {Key? key,
        this.initValue,
        required this.text,
        this.initText,
        required this.onChanged})
      : super(key: key);

  @override
  State<CheckBoxComponent> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxComponent> {
  bool isCheckBox = false;
  late String initTextSelect;

  @override
  void initState() {
    if (widget.initValue != null) {
      isCheckBox = widget.initValue!;
    }
    initTextSelect = widget.initText ?? widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCheckBox = !isCheckBox;
          widget.onChanged.call(initTextSelect, isCheckBox);
        });
      },
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isCheckBox
                    ? AppColors.primary_05
                    : AppColors.light_tabBar_bg),
            child: Visibility(
              visible: isCheckBox,
              child: const Icon(
                Icons.check,
                color: AppColors.light_bg,
                size: 15,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
              child: Text(
                widget.text,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: AppColors.neutral_02),
              ))
        ],
      ),
    );
  }

}