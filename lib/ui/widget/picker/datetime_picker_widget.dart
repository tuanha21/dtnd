import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

class DateTimePickerWidget extends StatefulWidget {
  const DateTimePickerWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.labelText,
  });
  final TextEditingController? controller;
  final ValueChanged<DateTime>? onChanged;
  final String? labelText;
  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("tapped");
      },
      child: TextField(
        controller: widget.controller,
        readOnly: true,
        autocorrect: false,
        enableSuggestions: false,
        enabled: false,
        decoration: InputDecoration(
            labelText: widget.labelText ?? "Label",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: SizedBox.square(
              dimension: 20,
              child: Image.asset(
                AppImages.asset_calendar_icon,
              ),
            ),
            suffixIconConstraints: const BoxConstraints(
                minHeight: 20, maxHeight: 20, minWidth: 36, maxWidth: 36)),
      ),
    );
  }
}
