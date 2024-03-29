import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';

final NumberFormat integerFormat = NumberFormat("###,###,###,###,###", "en_US");
final NumberFormat integerFormat10 =
    NumberFormat("###,###,###,###,##", "en_US");
final NumberFormat doubleFormat =
    NumberFormat("###,###,###,###,###.##", "en_US");

enum Compact { million, billion }

class NumUtils {
  static String formatDouble(num? integer, [String? nullString]) {
    if (_invalidInput(integer)) return nullString ?? "";
    try {
      return doubleFormat.format(integer);
    } catch (e) {
      return nullString ?? "";
    }
  }

  static String formatInteger(num? integer, [String? nullString]) {
    if (_invalidInput(integer)) return nullString ?? "";
    try {
      return integerFormat.format(integer);
    } catch (e) {
      return nullString ?? "";
    }
  }

  static String formatInteger10(num? integer, [String? nullString]) {
    if (_invalidInput(integer)) return nullString ?? "";
    try {
      return integerFormat10.format(integer);
    } catch (e) {
      return nullString ?? "";
    }
  }

  static String formatDoubleString(String? string, [String? nullString]) {
    if (_invalidInput(string)) return nullString ?? "";
    try {
      final num integer = num.parse(string!);
      return doubleFormat.format(integer);
    } catch (e) {
      return nullString ?? "";
    }
  }

  static String formatIntegerString(String? string, [String? nullString]) {
    if (_invalidInput(string)) return nullString ?? "";
    try {
      final num integer = num.parse(string!);
      return integerFormat.format(integer);
    } catch (e) {
      return nullString ?? "";
    }
  }

  static String formatIntegerString10(String? string, [String? nullString]) {
    if (_invalidInput(string)) return nullString ?? "";
    try {
      final num integer = num.parse(string!);
      return integerFormat10.format(integer);
    } catch (e) {
      return nullString ?? "";
    }
  }

  static bool _invalidInput(dynamic data) => data == null;

  static String getRandom() {
    String text = "";
    String possible =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    Random random = Random();
    for (int i = 0; i < 23; i++) {
      text += possible[(random.nextDouble() * possible.length).toInt()];
    }
    return text;
  }

  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static String getMoneyWithPostfix(num? number, BuildContext context) {
    if (number == null) {
      return "0";
    }
    int intValue = number ~/ 1;
    String i = intValue.toString();
    String postfix;
    String value;
    if (i.length < 9) {
      value = formatDouble(intValue / 1000000);
      postfix = S.of(context).million_short;
    } else {
      value = formatDouble(intValue / 1000000000);
      postfix = S.of(context).billion_short;
    }
    return "$value $postfix";
  }

  static String getMoneyWithPostfixThousand(num? number, BuildContext context,
      [String nullDefault = "-"]) {
    if (number == null) {
      return nullDefault;
    }
    int intValue = number ~/ 1;
    String postfix;
    String value;
    value = formatDouble(intValue / 1000);
    postfix = S.of(context).thousand_short;
    return "$value$postfix";
  }

  static num? parseString(String? string) {
    if (string == null) {
      return null;
    }

    return num.tryParse(string);
  }
}
