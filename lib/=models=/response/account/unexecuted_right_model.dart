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
  late num cSHAREBUY;
  late num cCASHBUY;
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
  late num cSHARERIGHT;
  late num cCASHBUYALL;
  String? cBUSINESSNAME;
  String? cBUSINESSNAMEEN;
  String? cBUSINESSCODE;

  num get shareAvailBuy => cSHARERIGHT - cSHAREBUY;

  num get cashAvailRight => cCASHBUYALL - cCASHBUY;

  bool get canRegistered {
    if (cFLAG == 1 && cSHAREBUY < cSHARERIGHT) {
      return true;
    }
    return false;
  }

  UnexecutedRightModel.fromJson(Map<String, dynamic> json) {
    pKRIGHTSTOCKINFO = json['PK_RIGHT_INFO'];
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
    cSHAREBUY = json['C_SHARE_BUY'] ?? 0;
    cCASHBUY = json['C_CASH_BUY'] ?? 0;
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
    cSHARERIGHT = json['C_SHARE_RIGHT'] ?? 0;
    cCASHBUYALL = json['C_CASH_BUY_ALL'] ?? 0;
    cBUSINESSCODE = json['C_BUSINESS_CODE'];
    cBUSINESSNAME = json['C_BUSINESS_NAME'];
    cBUSINESSNAMEEN = json['C_BUSINESS_NAME_EN'];
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
    data['C_BUSINESS_CODE'] = cBUSINESSCODE;
    data['C_BUSINESS_NAME'] = cBUSINESSNAME;
    data['C_BUSINESS_NAME_EN'] = cBUSINESSNAMEEN;
    return data;
  }
}
