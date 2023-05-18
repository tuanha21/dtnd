import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/utilities/logger.dart';

import 'order_model/i_order_model.dart';

class OrderHistoryModel implements CoreResponseModel {
  num? rOWNUM;
  String? pKORDER;
  String? cORDERNO;
  String? cACCOUNTCODE;
  late final String stockCode;
  late final Side side;
  String? cCHANEL;
  String? cCHANELNAME;
  String? cORDERDATE;
  String? cORDERTIME;
  num? cORDERVOLUME;
  num? cORDERPRICE;
  late final OrderStatus orderStatus;
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

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    logger.v(json);
    rOWNUM = json['ROW_NUM'];
    pKORDER = json['PK_ORDER'];
    cORDERNO = json['C_ORDER_NO'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    stockCode = json['C_SHARE_CODE'];
    side = SideHelper.fromString(json['C_SIDE']);
    cCHANEL = json['C_CHANEL'];
    cCHANELNAME = json['C_CHANEL_NAME'];
    cORDERDATE = json['C_ORDER_DATE'];
    cORDERTIME = json['C_ORDER_TIME'];
    cORDERVOLUME = json['C_ORDER_VOLUME'];
    cORDERPRICE = json['C_ORDER_PRICE'];
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
    orderStatus = _getStatusOrder(json['C_ORDER_STATUS']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ROW_NUM'] = rOWNUM;
    data['PK_ORDER'] = pKORDER;
    data['C_ORDER_NO'] = cORDERNO;
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_SHARE_CODE'] = stockCode;
    data['C_SIDE'] = side;
    data['C_CHANEL'] = cCHANEL;
    data['C_CHANEL_NAME'] = cCHANELNAME;
    data['C_ORDER_DATE'] = cORDERDATE;
    data['C_ORDER_TIME'] = cORDERTIME;
    data['C_ORDER_VOLUME'] = cORDERVOLUME;
    data['C_ORDER_PRICE'] = cORDERPRICE;
    data['C_ORDER_STATUS'] = orderStatus;
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

  OrderStatus _getStatusOrder(String status) {
    var pStatus = status;
    var pMatchVolume = cMATCHVOL ?? 0;
    var pVolume = cORDERVOLUME?.toInt().toString() ?? "0";

    if ((pStatus == "PMC" || pStatus == "PCM" || pStatus == "PWM") &&
        (pMatchVolume) < int.parse(pVolume)) {
      return OrderStatus.partialMatch; // "MATCH_PARTIAL";
    }
    if ((pStatus == "PMC" || pStatus == "PCM") &&
        (pMatchVolume) == int.parse(pVolume)) {
      return OrderStatus.fullMatch; // "MATCH_FULL";
    }

    if ((pStatus == "PMX" || pStatus == "PMWX") && (pMatchVolume) > 0) {
      return OrderStatus.partialMatchCanceled; // "MATCH_PARTIAL_CANCELED";
    }
    if (pStatus == "PM" && (pMatchVolume) < int.parse(pVolume)) {
      return OrderStatus.partialMatch; // "MATCH_PARTIAL";
    }
    if (pStatus.substring(pStatus.length - 1, pStatus.length) == "M") {
      //return "MATCH_FULL"
      return OrderStatus.fullMatch; // "MATCH_FULL";
    }
    if (pStatus == "PM") {
      // return "MATCH_FULL"
      return OrderStatus.fullMatch; // "MATCH_FULL";
    }
    if (pStatus == "PW" || pStatus == "PMW") {
      // return  "MATCH_PENDING"
      return OrderStatus.pendingCanceled; // "MATCH_PENDING";
    }
    if (pStatus == "PC") {
      return OrderStatus.pendingMatch; // "MATCH_PENDING";
      // if (pQuote == "Y") {
      //   return "Chờ khớp"; // "MATCH_PENDING";
      // } else {
      //   return "Đã sửa"; // "EDIT_PENDING"
      // } // Ba Ly bao sua thanh cho khop, neu sua lai thi la con cho'
    }
    if (pStatus.substring(pStatus.length - 1, pStatus.length) == "X") {
      return OrderStatus.canceled; // "CANCELED";
    }
    if (pStatus == "P") {
      return OrderStatus.pendingMatch; // "MATCH_PENDING";
    }
    if (pStatus.substring(pStatus.length - 1, pStatus.length) == "C") {
      return OrderStatus.pendingMatch; // "MATCH_PENDING";
    }
    return OrderStatus.unidentified;
  }
}
