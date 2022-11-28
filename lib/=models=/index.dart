// ignore_for_file: constant_identifier_names

enum Index { VN30, VNI, HNI, UPCOM }

extension IndexX on Index {
  String get code {
    switch (this) {
      case Index.VNI:
        return "10";
      case Index.VN30:
        return "11";
      case Index.HNI:
        return "02";
      case Index.UPCOM:
        return "03";
    }
  }

  String get exchangeName {
    switch (this) {
      case Index.VNI:
        return "VNIndex";
      case Index.VN30:
        return "VN30";
      case Index.HNI:
        return "HNXIndex";
      case Index.UPCOM:
        return "UPCOM";
    }
  }

  String get chartCode {
    switch (this) {
      case Index.VNI:
        return "VNINDEX";
      case Index.VN30:
        return "VN30";
      case Index.HNI:
        return "HNX";
      case Index.UPCOM:
        return "UPCOM";
    }
  }
}

class IndexUtil {
  static fromCode(String code) {
    switch (code) {
      case "10":
        return Index.VNI;
      case "11":
        return Index.VN30;
      case "02":
        return Index.HNI;
      default:
        return Index.UPCOM;
    }
  }
}
