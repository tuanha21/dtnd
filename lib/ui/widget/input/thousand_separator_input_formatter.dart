import 'package:flutter/services.dart';

class ThousandsSeparatorInputFormatter<T extends num>
    extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales
  static const decimal = '.'; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    // if (newValue.text.length == 0) {
    //   return newValue.copyWith(text: '');
    // }

    // Handle "deletion" of separator character

    newValue.text.replaceAll(RegExp('[^0-9]'), '');

    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}

class PricePercentageInputFormatter<T extends num>
    extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = '';
    if (newValue.text != '' &&
        (newValue.text.substring(0, 1) == ',' ||
            newValue.text.substring(0, 1) == '.')) {
      text = '0.';
    } else if (newValue.text.replaceAll(',', '.').split('.').length > 2) {
      text = newValue.text.substring(0, newValue.text.length - 1);
    } else {
      text = newValue.text.replaceAll(',', '.');
    }

    if (text.split('.').length > 2) {
      var parts = text.split('.');
      text = '${parts[0]}.${parts[1]}';
    }

    return TextEditingValue(
      text: text.replaceAll(',', '.').replaceAllMapped(
          RegExp(r"(\.\d{2})\d+"), (match) => match[1].toString()),
      selection: TextSelection.fromPosition(TextPosition(offset: text.length)),
    );
  }
}
