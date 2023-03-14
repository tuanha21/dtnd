enum MatchType { Match, MatchAndPutthrough }

extension MatchTypeX on MatchType {
  String get code {
    switch (this) {
      case MatchType.Match:
        return "M";
      case MatchType.MatchAndPutthrough:
        return "P";
    }
  }

  String get typeName {
    switch (this) {
      case MatchType.Match:
        return "Khớp lệnh";
      case MatchType.MatchAndPutthrough:
        return "Khớp lệnh và thỏa thuận";
    }
  }
}
