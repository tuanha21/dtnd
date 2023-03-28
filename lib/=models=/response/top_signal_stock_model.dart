import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/stock_status.dart';
import 'package:dtnd/utilities/time_utils.dart';

class TopSignalStockModel extends StockStatus {
  late final String cSHARECODE;
  late final StockModel stockModel;
  late final DateTime cBUYDATE;
  DateTime? cSELLDATE;
  late final String cTYPE;
  late final num cBUYPRICE;
  num? cSELLMIN;
  num? cSELLMAX;
  num? cSELLPRICE;
  num? cPC;
  num? t;
  late final String cColor;

  TopSignalStockModel.fromJson(Map<String, dynamic> json) {
    cSHARECODE = json['C_SHARE_CODE'];
    cBUYDATE =
        DateTime.fromMillisecondsSinceEpoch(json['C_BUY_DATE']).beginningOfDay;
    cSELLDATE = json['C_SELL_DATE'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['C_SELL_DATE'])
        : null;
    cTYPE = json['C_TYPE'];
    cBUYPRICE = json['C_BUY_PRICE'];
    cSELLMIN = json['C_SELL_MIN'];
    cSELLMAX = json['C_SELL_MAX'];
    cSELLPRICE = json['C_SELL_PRICE'];
    cPC = json['C_PC'];
    t = json['T'];
    cColor = json['C_COLOR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_SHARE_CODE'] = cSHARECODE;
    data['C_BUY_DATE'] = cBUYDATE;
    data['C_SELL_DATE'] = cSELLDATE;
    data['C_TYPE'] = cTYPE;
    data['C_BUY_PRICE'] = cBUYPRICE;
    data['C_SELL_MIN'] = cSELLMIN;
    data['C_SELL_MAX'] = cSELLMAX;
    data['C_SELL_PRICE'] = cSELLPRICE;
    data['C_PC'] = cPC;
    data['T'] = t;
    data['C_COLOR'] = cColor;
    return data;
  }

  @override
  SStatus get sstatus {
    switch (cColor) {
      case "i":
        return SStatus.up;
      case "d":
        return SStatus.down;
      default:
        return SStatus.ref;
    }
  }
}
