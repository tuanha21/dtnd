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
  num? c1W;
  num? c2W;
  num? c1M;
  num? c3M;
  String? rUIRO;

  List<num> get list => [c1W ?? 0, c2W ?? 0, c1M ?? 0, c3M ?? 0];

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
    c1W = (json['C_1W']);
    c2W = (json['C_2W']);
    c1M = (json['C_1M']);
    c3M = (json['C_3M']);
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
    data['C_1W'] = c1W;
    data['C_2W'] = c2W;
    data['C_1M'] = c1M;
    data['C_3M'] = c3M;
    data['RUI_RO'] = rUIRO;
    return data;
  }
}
