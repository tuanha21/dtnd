import 'package:dtnd/utilities/string_util.dart';
import 'package:flutter/material.dart';

typedef GetInterval = num Function(num);

class IntervalInput extends StatelessWidget {
  const IntervalInput({
    super.key,
    required this.controller,
    this.labelText,
    required this.interval,
    this.defaultValue = 0,
    this.onChanged,
  });
  final TextEditingController controller;
  final String? labelText;
  final GetInterval? interval;
  final num defaultValue;
  final ValueChanged<num>? onChanged;

  void _onMinus() {
    final oldValue = controller.text;

    if (oldValue.isNum) {
      num newValue = num.parse(oldValue);

      newValue -= (interval?.call(newValue) ?? 0);
      if (newValue < 0) {
        newValue += interval?.call(newValue) ?? 0;
      }
      String newString = newValue.toStringAsPrecision(4);
      controller.value = TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length,
        ),
      );
      onChanged?.call(newValue);
    } else if (oldValue.isOrderType) {
      String newString = defaultValue.toString();
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

      newValue += (interval?.call(newValue) ?? 0);
      String newString = newValue.toStringAsPrecision(4);
      controller.value = TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length,
        ),
      );
      onChanged?.call(newValue);
    } else if (oldValue.isOrderType) {
      String newString = defaultValue.toStringAsPrecision(4);
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
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: const EdgeInsets.all(0),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        prefixIcon:
            InkWell(onTap: _onMinus, child: const Icon(Icons.remove_rounded)),
        suffixIcon:
            InkWell(onTap: _onAdd, child: const Icon(Icons.add_rounded)),
      ),
    );
  }
}
