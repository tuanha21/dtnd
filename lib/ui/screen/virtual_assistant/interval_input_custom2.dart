import 'package:dtnd/ui/widget/input/thousand_separator_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/app_image.dart';

class IntervalInputCustom2 extends StatelessWidget {
  const IntervalInputCustom2({
    super.key,
    this.formKey,
    this.validator,
    required this.controller,
    this.labelText,
    this.defaultValue = 0,
    this.onChanged,
    this.onTextChanged,
  });

  final Key? formKey;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? labelText;
  final num defaultValue;
  final ValueChanged<num>? onChanged;
  final ValueChanged<String>? onTextChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        key: formKey,
        controller: controller,
        validator: validator,
        onChanged: onTextChanged,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [ThousandsSeparatorInputFormatter()],
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.only(left: 15),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(AppImages.icon_percent),
          ),
        ),
      ),
    );
  }
}
