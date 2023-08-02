import 'package:dtnd/ui/widget/input/thousand_separator_input_formatter.dart';
import 'package:dtnd/utilities/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/service/app_services.dart';
import '../../theme/app_color.dart';

typedef GetInterval = num Function(num);

class IntervalInput extends StatelessWidget {
  const IntervalInput(
      {super.key,
      this.formKey,
      this.validator,
      required this.controller,
      this.labelText,
      required this.interval,
      this.defaultValue = 0,
      this.onChanged,
      this.onTextChanged,
      this.listFormat});

  final Key? formKey;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? labelText;
  final GetInterval interval;
  final num defaultValue;
  final ValueChanged<num>? onChanged;
  final ValueChanged<String>? onTextChanged;
  final List<TextInputFormatter>? listFormat;

  void _onMinus() {
    final oldValue = controller.text;
    String newString;
    if (oldValue.isNum) {
      num newValue = num.parse(oldValue);
      newValue -= (interval.call(newValue));
      if (newValue < 0) {
        newValue += interval.call(newValue);
      }
      String newString = newValue.toStringAsFixed(2);
      newString = newString.replaceAll(".00", "");
      controller.value = TextEditingValue(
        text: newString.replaceAll(".00", ""),
        selection: TextSelection.collapsed(
          offset: newString.length,
        ),
      );
      onChanged?.call(newValue);
    } else if (oldValue.isOrderType) {
      newString = defaultValue.toString();
      newString = newString.replaceAll(".00", "");
      controller.value = TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length,
        ),
      );
      onChanged?.call(defaultValue);
    } else {
      return _onMinus();
    }
  }

  void _onAdd() {
    final oldValue = controller.text;

    if (oldValue.isNum) {
      num newValue = num.parse(oldValue);
      newValue += (interval.call(newValue));
      String newString = newValue.toStringAsFixed(2);
      newString = newString.replaceAll(".00", "");
      controller.value = TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length,
        ),
      );
      onChanged?.call(newValue);
    } else if (oldValue.isOrderType) {
      String newString = defaultValue.toStringAsFixed(2);
      newString = newString.replaceAll(".00", "");
      controller.value = TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length,
        ),
      );
      onChanged?.call(defaultValue);
    } else {
      return _onAdd();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Material(
      color: themeMode.isLight ? AppColors.neutral_07 : AppColors.neutral_01,
      child: TextFormField(
        textAlign: TextAlign.center,
        key: formKey,
        controller: controller,
        validator: validator,
        onChanged: onTextChanged,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: listFormat ?? [ThousandsSeparatorInputFormatter()],
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.all(0),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          prefixIcon: InkWell(
            onTap: _onMinus,
            child: Icon(
              Icons.remove_rounded,
              color: themeMode.isLight
                  ? AppColors.neutral_01
                  : AppColors.neutral_07,
            ),
          ),
          suffixIcon: InkWell(
            onTap: _onAdd,
            child: Icon(
              Icons.add_rounded,
              color: themeMode.isLight
                  ? AppColors.neutral_01
                  : AppColors.neutral_07,
            ),
          ),
        ),
      ),
    );
  }
}
