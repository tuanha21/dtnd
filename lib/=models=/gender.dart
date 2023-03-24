import 'package:dtnd/generated/l10n.dart';

enum Gender { male, female, other }

extension GenderX on Gender {
  String get call {
    switch (this) {
      case Gender.female:
        return S.current.female;
      case Gender.male:
        return S.current.male;
      default:
        return S.current.other;
    }
  }
}

class GenderHelper {
  static Gender fromCode(String? code) {
    switch (code) {
      case "F":
        return Gender.female;
      case "M":
        return Gender.male;
      default:
        return Gender.other;
    }
  }
}
