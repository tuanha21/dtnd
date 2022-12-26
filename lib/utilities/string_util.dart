import 'package:dtnd/utilities/regex.dart';

extension StringX on String {
  bool get isNum => numRegex.hasMatch(this);

  bool get isOrderType => orderTypeRegex.hasMatch(this);
}
