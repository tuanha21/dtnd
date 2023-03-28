import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/stock_status.dart';
import 'package:dtnd/utilities/logger.dart';

class ShareEarnedModel extends StockStatus {
  num? rOWNUM;
  String? cTRADINGDATE;
  String? cACCOUNTCODE;
  String? cSHARECODE;
  num? cSHAREVOLUME;
  num? cSHAREPRICE;
  num? cAVERAGEPRICE;
  num? cMATCHEDVALUE;
  num? cCOMMVALUE;
  num? cCASHVALUE;
  num? cRIGHTVOLUME;
  num? cRIGHTTAXVALUE;
  num? cCOSTVALUE;
  num? cEARNEDVALUE;
  num? cEARNEDRATE;
  num? cTOTALRECORD;
  List<ShareEarnedDetailModel> listDetail = [];

  ShareEarnedModel(
      {this.rOWNUM,
      this.cTRADINGDATE,
      this.cACCOUNTCODE,
      this.cSHARECODE,
      this.cSHAREVOLUME,
      this.cSHAREPRICE,
      this.cAVERAGEPRICE,
      this.cMATCHEDVALUE,
      this.cCOMMVALUE,
      this.cCASHVALUE,
      this.cRIGHTVOLUME,
      this.cRIGHTTAXVALUE,
      this.cCOSTVALUE,
      this.cEARNEDVALUE,
      this.cEARNEDRATE,
      this.cTOTALRECORD});

  factory ShareEarnedModel.fromListDetail(List<ShareEarnedDetailModel>? list) {
    if (list?.isEmpty ?? true) {
      return ShareEarnedModel();
    }
    try {
      final ShareEarnedModel model = ShareEarnedModel.fromJson(
          list!.firstWhere((element) => element.rOWNUM == 9999999).toJson());
      model.listDetail.clear();
      for (ShareEarnedDetailModel detail in list) {
        if (detail.rOWNUM != 9999999) {
          model.listDetail.add(detail);
        }
      }
      return model;
    } catch (e) {
      logger.e(e);
      return ShareEarnedModel();
    }
  }

  ShareEarnedModel.fromJson(Map<String, dynamic> json) {
    cTRADINGDATE = json['C_TRADING_DATE'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cSHARECODE = json['C_SHARE_CODE'];
    cSHAREVOLUME = json['C_SHARE_VOLUME'];
    cSHAREPRICE = json['C_SHARE_PRICE'];
    cAVERAGEPRICE = json['C_AVERAGE_PRICE'];
    cMATCHEDVALUE = json['C_MATCHED_VALUE'];
    cCOMMVALUE = json['C_COMM_VALUE'];
    cCASHVALUE = json['C_CASH_VALUE'];
    cRIGHTVOLUME = json['C_RIGHT_VOLUME'];
    cRIGHTTAXVALUE = json['C_RIGHT_TAX_VALUE'];
    cCOSTVALUE = json['C_COST_VALUE'];
    cEARNEDVALUE = json['C_EARNED_VALUE'];
    cEARNEDRATE = json['C_EARNED_RATE'];
    cTOTALRECORD = json['C_TOTAL_RECORD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ROW_NUM'] = rOWNUM;
    data['C_TRADING_DATE'] = cTRADINGDATE;
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_SHARE_CODE'] = cSHARECODE;
    data['C_SHARE_VOLUME'] = cSHAREVOLUME;
    data['C_SHARE_PRICE'] = cSHAREPRICE;
    data['C_AVERAGE_PRICE'] = cAVERAGEPRICE;
    data['C_MATCHED_VALUE'] = cMATCHEDVALUE;
    data['C_COMM_VALUE'] = cCOMMVALUE;
    data['C_CASH_VALUE'] = cCASHVALUE;
    data['C_RIGHT_VOLUME'] = cRIGHTVOLUME;
    data['C_RIGHT_TAX_VALUE'] = cRIGHTTAXVALUE;
    data['C_COST_VALUE'] = cCOSTVALUE;
    data['C_EARNED_VALUE'] = cEARNEDVALUE;
    data['C_EARNED_RATE'] = cEARNEDRATE;
    data['C_TOTAL_RECORD'] = cTOTALRECORD;
    return data;
  }

  @override
  SStatus get sstatus {
    if ((cEARNEDVALUE ?? 0) > 0 && (cEARNEDRATE ?? 0) > 0) {
      return SStatus.up;
    } else {
      return SStatus.down;
    }
  }
}

class ShareEarnedDetailModel implements CoreResponseModel {
  num? rOWNUM;
  String? cTRADINGDATE;
  String? cACCOUNTCODE;
  String? cSHARECODE;
  num? cSHAREVOLUME;
  num? cSHAREPRICE;
  num? cAVERAGEPRICE;
  num? cMATCHEDVALUE;
  num? cCOMMVALUE;
  num? cCASHVALUE;
  num? cRIGHTVOLUME;
  num? cRIGHTTAXVALUE;
  num? cCOSTVALUE;
  num? cEARNEDVALUE;
  num? cEARNEDRATE;
  num? cTOTALRECORD;

  ShareEarnedDetailModel(
      {this.rOWNUM,
      this.cTRADINGDATE,
      this.cACCOUNTCODE,
      this.cSHARECODE,
      this.cSHAREVOLUME,
      this.cSHAREPRICE,
      this.cAVERAGEPRICE,
      this.cMATCHEDVALUE,
      this.cCOMMVALUE,
      this.cCASHVALUE,
      this.cRIGHTVOLUME,
      this.cRIGHTTAXVALUE,
      this.cCOSTVALUE,
      this.cEARNEDVALUE,
      this.cEARNEDRATE,
      this.cTOTALRECORD});

  ShareEarnedDetailModel.fromJson(Map<String, dynamic> json) {
    logger.v(json);
    rOWNUM = json['ROW_NUM'];
    cTRADINGDATE = json['C_TRADING_DATE'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cSHARECODE = json['C_SHARE_CODE'];
    cSHAREVOLUME = json['C_SHARE_VOLUME'];
    cSHAREPRICE = json['C_SHARE_PRICE'];
    cAVERAGEPRICE = json['C_AVERAGE_PRICE'];
    cMATCHEDVALUE = json['C_MATCHED_VALUE'];
    cCOMMVALUE = json['C_COMM_VALUE'];
    cCASHVALUE = json['C_CASH_VALUE'];
    cRIGHTVOLUME = json['C_RIGHT_VOLUME'];
    cRIGHTTAXVALUE = json['C_RIGHT_TAX_VALUE'];
    cCOSTVALUE = json['C_COST_VALUE'];
    cEARNEDVALUE = json['C_EARNED_VALUE'];
    cEARNEDRATE = json['C_EARNED_RATE'];
    cTOTALRECORD = json['C_TOTAL_RECORD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ROW_NUM'] = rOWNUM;
    data['C_TRADING_DATE'] = cTRADINGDATE;
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_SHARE_CODE'] = cSHARECODE;
    data['C_SHARE_VOLUME'] = cSHAREVOLUME;
    data['C_SHARE_PRICE'] = cSHAREPRICE;
    data['C_AVERAGE_PRICE'] = cAVERAGEPRICE;
    data['C_MATCHED_VALUE'] = cMATCHEDVALUE;
    data['C_COMM_VALUE'] = cCOMMVALUE;
    data['C_CASH_VALUE'] = cCASHVALUE;
    data['C_RIGHT_VOLUME'] = cRIGHTVOLUME;
    data['C_RIGHT_TAX_VALUE'] = cRIGHTTAXVALUE;
    data['C_COST_VALUE'] = cCOSTVALUE;
    data['C_EARNED_VALUE'] = cEARNEDVALUE;
    data['C_EARNED_RATE'] = cEARNEDRATE;
    data['C_TOTAL_RECORD'] = cTOTALRECORD;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
