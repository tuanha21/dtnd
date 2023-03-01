import 'package:dtnd/=models=/core_response_model.dart';

class OrderHistoryModel implements CoreResponseModel {
  num? rOWNUM;
  String? pKORDER;
  num? cORDERNO;
  String? cACCOUNTCODE;
  String? cSHARECODE;
  String? cSIDE;
  String? cCHANEL;
  String? cCHANELNAME;
  String? cORDERDATE;
  String? cORDERTIME;
  num? cORDERVOLUME;
  num? cORDERPRICE;
  String? cORDERSTATUS;
  String? cSHOWSTATUS;
  String? cSTATUSNAME;
  String? cSTATUSNAMEEN;
  String? cSHOWPRICE;
  String? cSETORDERTYPE;
  String? cCONFIRMSTATUS;
  String? cCONFIRMTIME;
  num? cMATCHVOL;
  num? cUNMATCHVOL;
  num? cMATCHPRICE;
  num? cFEEVALUE;
  num? cTAXVALUE;
  num? cMATCHEDVALUE;
  num? cTOTALRECORD;

  OrderHistoryModel(
      {this.rOWNUM,
      this.pKORDER,
      this.cORDERNO,
      this.cACCOUNTCODE,
      this.cSHARECODE,
      this.cSIDE,
      this.cCHANEL,
      this.cCHANELNAME,
      this.cORDERDATE,
      this.cORDERTIME,
      this.cORDERVOLUME,
      this.cORDERPRICE,
      this.cORDERSTATUS,
      this.cSHOWSTATUS,
      this.cSTATUSNAME,
      this.cSTATUSNAMEEN,
      this.cSHOWPRICE,
      this.cSETORDERTYPE,
      this.cCONFIRMSTATUS,
      this.cCONFIRMTIME,
      this.cMATCHVOL,
      this.cUNMATCHVOL,
      this.cMATCHPRICE,
      this.cFEEVALUE,
      this.cTAXVALUE,
      this.cMATCHEDVALUE,
      this.cTOTALRECORD});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    rOWNUM = json['ROW_NUM'];
    pKORDER = json['PK_ORDER'];
    cORDERNO = json['C_ORDER_NO'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cSHARECODE = json['C_SHARE_CODE'];
    cSIDE = json['C_SIDE'];
    cCHANEL = json['C_CHANEL'];
    cCHANELNAME = json['C_CHANEL_NAME'];
    cORDERDATE = json['C_ORDER_DATE'];
    cORDERTIME = json['C_ORDER_TIME'];
    cORDERVOLUME = json['C_ORDER_VOLUME'];
    cORDERPRICE = json['C_ORDER_PRICE'];
    cORDERSTATUS = json['C_ORDER_STATUS'];
    cSHOWSTATUS = json['C_SHOW_STATUS'];
    cSTATUSNAME = json['C_STATUS_NAME'];
    cSTATUSNAMEEN = json['C_STATUS_NAME_EN'];
    cSHOWPRICE = json['C_SHOW_PRICE'];
    cSETORDERTYPE = json['C_SET_ORDER_TYPE'];
    cCONFIRMSTATUS = json['C_CONFIRM_STATUS'];
    cCONFIRMTIME = json['C_CONFIRM_TIME'];
    cMATCHVOL = json['C_MATCH_VOL'];
    cUNMATCHVOL = json['C_UNMATCH_VOL'];
    cMATCHPRICE = json['C_MATCH_PRICE'];
    cFEEVALUE = json['C_FEE_VALUE'];
    cTAXVALUE = json['C_TAX_VALUE'];
    cMATCHEDVALUE = json['C_MATCHED_VALUE'];
    cTOTALRECORD = json['C_TOTAL_RECORD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ROW_NUM'] = rOWNUM;
    data['PK_ORDER'] = pKORDER;
    data['C_ORDER_NO'] = cORDERNO;
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_SHARE_CODE'] = cSHARECODE;
    data['C_SIDE'] = cSIDE;
    data['C_CHANEL'] = cCHANEL;
    data['C_CHANEL_NAME'] = cCHANELNAME;
    data['C_ORDER_DATE'] = cORDERDATE;
    data['C_ORDER_TIME'] = cORDERTIME;
    data['C_ORDER_VOLUME'] = cORDERVOLUME;
    data['C_ORDER_PRICE'] = cORDERPRICE;
    data['C_ORDER_STATUS'] = cORDERSTATUS;
    data['C_SHOW_STATUS'] = cSHOWSTATUS;
    data['C_STATUS_NAME'] = cSTATUSNAME;
    data['C_STATUS_NAME_EN'] = cSTATUSNAMEEN;
    data['C_SHOW_PRICE'] = cSHOWPRICE;
    data['C_SET_ORDER_TYPE'] = cSETORDERTYPE;
    data['C_CONFIRM_STATUS'] = cCONFIRMSTATUS;
    data['C_CONFIRM_TIME'] = cCONFIRMTIME;
    data['C_MATCH_VOL'] = cMATCHVOL;
    data['C_UNMATCH_VOL'] = cUNMATCHVOL;
    data['C_MATCH_PRICE'] = cMATCHPRICE;
    data['C_FEE_VALUE'] = cFEEVALUE;
    data['C_TAX_VALUE'] = cTAXVALUE;
    data['C_MATCHED_VALUE'] = cMATCHEDVALUE;
    data['C_TOTAL_RECORD'] = cTOTALRECORD;
    return data;
  }
}
