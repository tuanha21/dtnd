import 'package:dtnd/=models=/stock_status.dart';
import 'package:dtnd/utilities/time_utils.dart';

class SignalMonthModel extends StockStatus {
  late final DateTime cMONTH;
  num? cPC;
  num? nUM;

  SignalMonthModel.fromJson(Map<String, dynamic> json) {
    cMONTH = TimeUtilities.monthYearTimeFormat.parse(json['C_MONTH']);
    cPC = json['C_PC'] ?? 0;
    nUM = json['NUM'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_MONTH'] = cMONTH;
    data['C_PC'] = cPC;
    data['NUM'] = nUM;
    return data;
  }

  @override
  String toString() {
    return 'SignalMonthModel{cMONTH: $cMONTH, cPC: $cPC, nUM: $nUM}';
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
