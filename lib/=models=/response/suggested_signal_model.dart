import 'package:dtnd/=models=/stock_status.dart';

class SuggestedSignalModel extends StockStatus {
  late final String cSHARECODE;
  late final String cTYPE;
  num? cPC;
  num? t;
  late final num cGAIN;
  late final num cLOSS;

  double get ratio {
    final total = cGAIN + cLOSS;
    if (total == 0) {
      return 0;
    } else {
      return (cGAIN / total) * 100;
    }
  }

  SuggestedSignalModel.fromJson(Map<String, dynamic> json) {
    cSHARECODE = json['C_SHARE_CODE'];
    cTYPE = json['C_TYPE'];
    cPC = json['C_PC'];
    t = json['T'];
    cGAIN = json['C_GAIN'] ?? 0;
    cLOSS = json['C_LOSS'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_SHARE_CODE'] = cSHARECODE;
    data['C_TYPE'] = cTYPE;
    data['C_PC'] = cPC;
    data['T'] = t;
    data['C_GAIN'] = cGAIN;
    data['C_LOSS'] = cLOSS;
    return data;
  }

  @override
  SStatus get sstatus {
    switch (cPC?.compareTo(0)) {
      case 1:
        return SStatus.up;
      case -1:
        return SStatus.down;
      default:
        return SStatus.ref;
    }
  }
}
