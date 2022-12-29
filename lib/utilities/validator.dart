import 'package:dtnd/generated/l10n.dart';

class AppValidator {
  static String? pinValidator(String? pin) {
    if (pin?.isEmpty ?? true) {
      return "Không được bỏ trống";
    }
    if (pin!.length < 6) {
      return "Pin quá ngắn";
    }
    return null;
  }
}
