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
    return TextField(
      controller: widget.controller,
      readOnly: true,
      autocorrect: false,
      enableSuggestions: false,
      enabled: true,
      decoration: InputDecoration(
          labelText: widget.labelText,
          suffix: Container(
            color: Colors.red,
          )),
    );
  }
}
