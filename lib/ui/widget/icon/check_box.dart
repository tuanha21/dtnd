import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppCheckBox extends StatefulWidget {
  final bool? initValue;
  final ValueChanged<bool>? onChanged;

  const AppCheckBox({Key? key, this.initValue,  this.onChanged}) : super(key: key);

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  late bool _isSelect = false;

  @override
  void initState() {
    if (widget.initValue != null) {
      _isSelect = widget.initValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelect = !_isSelect;
          widget.onChanged?.call(_isSelect);
        });
      },
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: _isSelect
                ? null
                : Border.all(width: 1.5, color: AppColors.neutral_03),
            color: _isSelect ? AppColors.primary_01 : null),
        child: Visibility(
          visible: _isSelect,
          child: const Icon(Icons.check, size: 20),
        ),
      ),
    );
  }
}
