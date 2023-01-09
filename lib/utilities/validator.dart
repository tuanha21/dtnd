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

  static String? catalogNameValidator(String? name) {
    if (name?.isEmpty ?? true) {
      return "Không được bỏ trống";
    }
    return null;
  }
}
