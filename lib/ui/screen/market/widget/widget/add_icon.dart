import 'package:flutter/material.dart';

import '../../../../theme/app_color.dart';

class AddStockIcon extends StatefulWidget {
  final bool initAdd;
  final ValueChanged<bool>? onChanged;

  const AddStockIcon({Key? key, required this.initAdd, this.onChanged})
      : super(key: key);

  @override
  State<AddStockIcon> createState() => _AddStockIconState();
}

class _AddStockIconState extends State<AddStockIcon> {
  bool isAdd = false;

  @override
  void initState() {
    isAdd = widget.initAdd;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.onChanged != null,
        child: GestureDetector(
            onTap: () {
              setState(() {
                isAdd = !isAdd;
                widget.onChanged?.call(isAdd);
              });
            },
            child: Icon(
              isAdd ? Icons.check_circle : Icons.add_circle,
              color: isAdd ? AppColors.primary_01 : AppColors.neutral_04,
            )));
  }
}
