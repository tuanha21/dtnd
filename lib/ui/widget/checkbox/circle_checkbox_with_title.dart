import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class CircleCheckboxWithTitle extends StatefulWidget {
  const CircleCheckboxWithTitle(
      {super.key,
      this.onChanged,
      required this.title,
      this.initialValue,
      this.doubleTapToUncheck = true});
  final ValueChanged<bool>? onChanged;
  final String title;
  final bool? initialValue;
  final bool doubleTapToUncheck;
  @override
  State<CircleCheckboxWithTitle> createState() =>
      _CircleCheckboxWithTitleState();
}

class _CircleCheckboxWithTitleState extends State<CircleCheckboxWithTitle> {
  late bool isCheck;
  @override
  void initState() {
    isCheck = widget.initialValue ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () {
              if (isCheck && widget.doubleTapToUncheck) {
                setState(() {
                  isCheck = !isCheck;
                });
              } else {
                setState(() {
                  isCheck = true;
                });
              }
              widget.onChanged?.call(isCheck);
            },
            child: Ink(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: isCheck
                          ? AppColors.primary_01
                          : AppColors.neutral_03)),
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCheck ? AppColors.primary_01 : Colors.transparent),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(widget.title)
      ],
    );
  }
}
