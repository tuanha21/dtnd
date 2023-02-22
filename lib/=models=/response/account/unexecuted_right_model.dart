import 'package:dtnd/=models=/core_response_model.dart';

class UnexecutedRightModel implements CoreResponseModel {
  late final String pKRIGHTSTOCKINFO;
  String? cRIGHTTYPENAME;
  String? cRIGHTTYPENAMEEN;
  num? cRIGHTBUYFLAG;
  String? cRIGHTRATE;
  num? cCASHRECEIVERATE;
  String? cSHARECODE;
  String? cSHARENAME;
  String? cRECEIVESHARECODE;
  String? cXDATE;
  String? cCLOSEDATE;
  String? cEXECUTEDATE;
  String? cDUEDATE;
  String? cTRANSFERFROMDATE;
  String? cTRANSFERTODATE;
  String? cREGISTERFROMDATE;
  String? cREGISTERTODATE;
  String? cTRANSFERTYPE;
  num? cFLAG;
  String? cTRANSFERNAME;
  String? cSTATUSNAME;
  String? cSTATUSNAMEEN;
  String? cACCOUNTCODE;
  num? cBUYPRICE;
  num? cSHAREBUY;
  num? cCASHBUY;
  num? cSHAREDIVIDENT;
  num? cSHAREODDLOT;
  num? cCASHODDLOT;
  num? cCASHVOLUME;
  num? cTAXVOLUME;
  String? cNOTE;
  num? cSHAREVOLUME;
  num? cRIGHTRECEIVER;
  num? cRIGHTTRANSFER;
  num? cRIGHTVOLUME;
  num? cSHARERIGHT;
  num? cCASHBUYALL;

  bool get canRegistered {
    if (cFLAG == 1 && (cSHAREBUY ?? double.maxFinite) < (cSHARERIGHT ?? -1)) {
      return true;
    }
    return false;
  }

  UnexecutedRightModel(
      {required this.pKRIGHTSTOCKINFO,
      this.cRIGHTTYPENAME,
      this.cRIGHTTYPENAMEEN,
      this.cRIGHTBUYFLAG,
      this.cRIGHTRATE,
      this.cCASHRECEIVERATE,
      this.cSHARECODE,
      this.cSHARENAME,
      this.cRECEIVESHARECODE,
      this.cXDATE,
      this.cCLOSEDATE,
      this.cEXECUTEDATE,
      this.cDUEDATE,
      this.cTRANSFERFROMDATE,
      this.cTRANSFERTODATE,
      this.cREGISTERFROMDATE,
      this.cREGISTERTODATE,
      this.cTRANSFERTYPE,
      this.cFLAG,
      this.cTRANSFERNAME,
      this.cSTATUSNAME,
      this.cSTATUSNAMEEN,
      this.cACCOUNTCODE,
      this.cBUYPRICE,
      this.cSHAREBUY,
      this.cCASHBUY,
      this.cSHAREDIVIDENT,
      this.cSHAREODDLOT,
      this.cCASHODDLOT,
      this.cCASHVOLUME,
      this.cTAXVOLUME,
      this.cNOTE,
      this.cSHAREVOLUME,
      this.cRIGHTRECEIVER,
      this.cRIGHTTRANSFER,
      this.cRIGHTVOLUME,
      this.cSHARERIGHT,
      this.cCASHBUYALL});

  UnexecutedRightModel.fromJson(Map<String, dynamic> json) {
    pKRIGHTSTOCKINFO = json['PK_RIGHT_STOCK_INFO'];
    cRIGHTTYPENAME = json['C_RIGHT_TYPE_NAME'];
    cRIGHTTYPENAMEEN = json['C_RIGHT_TYPE_NAME_EN'];
    cRIGHTBUYFLAG = json['C_RIGHT_BUY_FLAG'];
    cRIGHTRATE = json['C_RIGHT_RATE'];
    cCASHRECEIVERATE = json['C_CASH_RECEIVE_RATE'];
    cSHARECODE = json['C_SHARE_CODE'];
    cSHARENAME = json['C_SHARE_NAME'];
    cRECEIVESHARECODE = json['C_RECEIVE_SHARE_CODE'];
    cXDATE = json['C_XDATE'];
    cCLOSEDATE = json['C_CLOSE_DATE'];
    cEXECUTEDATE = json['C_EXECUTE_DATE'];
    cDUEDATE = json['C_DUE_DATE'];
    cTRANSFERFROMDATE = json['C_TRANSFER_FROM_DATE'];
    cTRANSFERTODATE = json['C_TRANSFER_TO_DATE'];
    cREGISTERFROMDATE = json['C_REGISTER_FROM_DATE'];
    cREGISTERTODATE = json['C_REGISTER_TO_DATE'];
    cTRANSFERTYPE = json['C_TRANSFER_TYPE'];
    cFLAG = json['C_FLAG'];
    cTRANSFERNAME = json['C_TRANSFER_NAME'];
    cSTATUSNAME = json['C_STATUS_NAME'];
    cSTATUSNAMEEN = json['C_STATUS_NAME_EN'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cBUYPRICE = json['C_BUY_PRICE'];
    cSHAREBUY = json['C_SHARE_BUY'];
    cCASHBUY = json['C_CASH_BUY'];
    cSHAREDIVIDENT = json['C_SHARE_DIVIDENT'];
    cSHAREODDLOT = json['C_SHARE_ODD_LOT'];
    cCASHODDLOT = json['C_CASH_ODD_LOT'];
    cCASHVOLUME = json['C_CASH_VOLUME'];
    cTAXVOLUME = json['C_TAX_VOLUME'];
    cNOTE = json['C_NOTE'];
    cSHAREVOLUME = json['C_SHARE_VOLUME'];
    cRIGHTRECEIVER = json['C_RIGHT_RECEIVER'];
    cRIGHTTRANSFER = json['C_RIGHT_TRANSFER'];
    cRIGHTVOLUME = json['C_RIGHT_VOLUME'];
    cSHARERIGHT = json['C_SHARE_RIGHT'];
    cCASHBUYALL = json['C_CASH_BUY_ALL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PK_RIGHT_STOCK_INFO'] = pKRIGHTSTOCKINFO;
    data['C_RIGHT_TYPE_NAME'] = cRIGHTTYPENAME;
    data['C_RIGHT_TYPE_NAME_EN'] = cRIGHTTYPENAMEEN;
    data['C_RIGHT_BUY_FLAG'] = cRIGHTBUYFLAG;
    data['C_RIGHT_RATE'] = cRIGHTRATE;
    data['C_CASH_RECEIVE_RATE'] = cCASHRECEIVERATE;
    data['C_SHARE_CODE'] = cSHARECODE;
    data['C_SHARE_NAME'] = cSHARENAME;
    data['C_RECEIVE_SHARE_CODE'] = cRECEIVESHARECODE;
    data['C_XDATE'] = cXDATE;
    data['C_CLOSE_DATE'] = cCLOSEDATE;
    data['C_EXECUTE_DATE'] = cEXECUTEDATE;
    data['C_DUE_DATE'] = cDUEDATE;
    data['C_TRANSFER_FROM_DATE'] = cTRANSFERFROMDATE;
    data['C_TRANSFER_TO_DATE'] = cTRANSFERTODATE;
    data['C_REGISTER_FROM_DATE'] = cREGISTERFROMDATE;
    data['C_REGISTER_TO_DATE'] = cREGISTERTODATE;
    data['C_TRANSFER_TYPE'] = cTRANSFERTYPE;
    data['C_FLAG'] = cFLAG;
    data['C_TRANSFER_NAME'] = cTRANSFERNAME;
    data['C_STATUS_NAME'] = cSTATUSNAME;
    data['C_STATUS_NAME_EN'] = cSTATUSNAMEEN;
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_BUY_PRICE'] = cBUYPRICE;
    data['C_SHARE_BUY'] = cSHAREBUY;
    data['C_CASH_BUY'] = cCASHBUY;
    data['C_SHARE_DIVIDENT'] = cSHAREDIVIDENT;
    data['C_SHARE_ODD_LOT'] = cSHAREODDLOT;
    data['C_CASH_ODD_LOT'] = cCASHODDLOT;
    data['C_CASH_VOLUME'] = cCASHVOLUME;
    data['C_TAX_VOLUME'] = cTAXVOLUME;
    data['C_NOTE'] = cNOTE;
    data['C_SHARE_VOLUME'] = cSHAREVOLUME;
    data['C_RIGHT_RECEIVER'] = cRIGHTRECEIVER;
    data['C_RIGHT_TRANSFER'] = cRIGHTTRANSFER;
    data['C_RIGHT_VOLUME'] = cRIGHTVOLUME;
    data['C_SHARE_RIGHT'] = cSHARERIGHT;
    data['C_CASH_BUY_ALL'] = cCASHBUYALL;
    return data;
  }
}
