import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';

class DateTimePickerWidget extends StatefulWidget {
  const DateTimePickerWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.labelText,
    this.firstDate,
    this.lastDate,
  });
  final TextEditingController? controller;
  final ValueChanged<DateTime>? onChanged;
  final String? labelText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  late final TextEditingController _controller;
  late final DateTime firstDate;
  late final DateTime lastDate;
  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();

    _controller.text = TimeUtilities.commonTimeFormat.format(initialDate);
    firstDate =
        widget.firstDate ?? initialDate.subtract(TimeUtilities.month(1));
    lastDate = widget.lastDate ?? initialDate.add(TimeUtilities.month(1));
    super.initState();
  }

  DateTime get initialDate {
    if (_controller.text.isEmpty) {
      return DateTime.now();
    } else {
      try {
        return TimeUtilities.commonTimeFormat.parse(widget.controller!.text);
      } catch (e) {
        return DateTime.now();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.primary_01, // header background color
                  onPrimary: Colors.black, // header text color
                  onSurface: Colors.black, // body text color
                ),
              ),
              child: child!,
            );
          },
        );
        if (selectedDate != null) {
          _controller.text =
              TimeUtilities.commonTimeFormat.format(selectedDate);
          widget.onChanged?.call(selectedDate);
        }
      },
      child: TextField(
        controller: _controller,
        readOnly: true,
        autocorrect: false,
        enableSuggestions: false,
        enabled: false,
        decoration: InputDecoration(
          isDense: true,
          labelText: widget.labelText ?? "Label",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8, left: 0),
            child: SizedBox.square(
              dimension: 20,
              child: Image.asset(
                AppImages.asset_calendar_icon,
              ),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          suffixIconConstraints: const BoxConstraints(maxWidth: 28),
        ),
      ),
    );
  }
}
