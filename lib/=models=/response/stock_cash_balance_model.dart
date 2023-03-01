import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/num_utils.dart';

class StockCashBalanceModel implements CoreResponseModel {
  String? accCode;
  String? accType;
  String? sym;
  late final num ee;
  late final num marginratio;
  late final num imCk;
  late final num pp;
  late final num volumeAvaiable;
  late final num balance;
  String? color;
  String? accName;

  StockCashBalanceModel.fromJson(Map<String, dynamic> json) {
    accCode = json['accCode'];
    accType = json['accType'];
    sym = json['sym'];
    ee = NumUtils.parseString(json['ee']) ?? 0;
    marginratio = NumUtils.parseString(json['marginratio']) ?? 0;
    imCk = NumUtils.parseString(json['im_ck']) ?? 0;
    pp = NumUtils.parseString(json['pp']) ?? 0;
    volumeAvaiable = NumUtils.parseString(json['volumeAvaiable']) ?? 0;
    balance = NumUtils.parseString(json['balance']) ?? 0;
    color = json['color'];
    accName = json['accName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accCode'] = accCode;
    data['accType'] = accType;
    data['sym'] = sym;
    data['ee'] = ee;
    data['marginratio'] = marginratio;
    data['im_ck'] = imCk;
    data['pp'] = pp;
    data['volumeAvaiable'] = volumeAvaiable;
    data['balance'] = balance;
    data['color'] = color;
    data['accName'] = accName;
    return data;
  }
}
