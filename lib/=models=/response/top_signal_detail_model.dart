import 'dart:convert';

import 'package:dtnd/utilities/logger.dart';

const String _defaultList =
    "[[\"1M\",\"30\",\"0\"],[\"2M\",\"60\",\"0\"],[\"3M\",\"90\",\"0\"],[\"6M\",\"180\",\"0\"]]";

class TopSignalDetailModel {
  late final String cSHARECODE;
  late final DateTime cBUYDATE;
  String? cTYPE;
  num? cBUYPRICE;
  num? cSELLMIN;
  num? cSELLMAX;
  num? cSELLPRICE;
  num? cPC;
  num? t;
  late List<ValuePerPeriod> clist;
  String? rUIRO;

  TopSignalDetailModel.fromJson(Map<String, dynamic> json) {
    cSHARECODE = json['C_SHARE_CODE'];
    cBUYDATE = DateTime.fromMillisecondsSinceEpoch(json['C_BUY_DATE']);
    cTYPE = json['C_TYPE'];
    cBUYPRICE = json['C_BUY_PRICE'];
    cSELLMIN = json['C_SELL_MIN'];
    cSELLMAX = json['C_SELL_MAX'];
    cSELLPRICE = json['C_SELL_PRICE'];
    cPC = json['C_PC'];
    t = json['T'];
    // logger.v(json['C_LIST']);
    try {
      if (json['C_LIST'] is String) {
        final List<dynamic> listEffect = jsonDecode(json['C_LIST']);
        clist = listEffect.map((e) => ValuePerPeriod.fromJson(e)).toList();
      } else {
        final List<List<String>> listEffect = jsonDecode(_defaultList);
        clist = listEffect.map((e) => ValuePerPeriod.fromJson(e)).toList();
      }
    } catch (e) {
      final List<List<String>> listEffect = jsonDecode(_defaultList);
      clist = listEffect.map((e) => ValuePerPeriod.fromJson(e)).toList();
    }

    rUIRO = json['RUI_RO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_SHARE_CODE'] = cSHARECODE;
    data['C_BUY_DATE'] = cBUYDATE;
    data['C_TYPE'] = cTYPE;
    data['C_BUY_PRICE'] = cBUYPRICE;
    data['C_SELL_MIN'] = cSELLMIN;
    data['C_SELL_MAX'] = cSELLMAX;
    data['C_SELL_PRICE'] = cSELLPRICE;
    data['C_PC'] = cPC;
    data['T'] = t;
    data['RUI_RO'] = rUIRO;
    return data;
  }
}

class ValuePerPeriod {
  late final String label;
  late final num day;
  late final num per;

  ValuePerPeriod.fromJson(dynamic json) {
    label = json[0];
    day = num.parse(json[1]);
    per = num.parse(json[2]);
  }

  ValuePerPeriod.defaultVal() {
    label = "1M";
    day = 30;
    per = 0;
  }
}
