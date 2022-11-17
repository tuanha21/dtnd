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
}
