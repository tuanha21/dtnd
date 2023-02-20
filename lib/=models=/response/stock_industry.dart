import 'package:flutter/material.dart';

import '../../ui/theme/app_color.dart';

class StockIndustry {
  String? sTOCKCODE;
  num? vHTT;
  String? sTOCKNAME;
  String? iNDUSTRY;
  String? sECONDINDUSTRY;
  num? dEVIEND;
  num? gTGD;
  num? pERCENTCHANGE;
  num? uPDATEDTIME;
  num? cHANGE;
  String? cOLOR;
  num? kLGD;
  num? lASTPRICE;
  num? iNTERESTED;
  String? cHARTNOTIME;
  String? cATID;
  num? pERCENTRANGEPRICE;
  num? tOP30;

  Color get stockColor {
    switch (cOLOR) {
      case "green":
        return AppColors.semantic_01;
      case "red":
        return AppColors.semantic_03;
      case "violet":
        return AppColors.semantic_05;
      case "blue":
        return AppColors.semantic_04;
      default:
        return AppColors.semantic_02;
    }
  }

  StockIndustry(
      {this.sTOCKCODE,
        this.vHTT,
        this.sTOCKNAME,
        this.iNDUSTRY,
        this.sECONDINDUSTRY,
        this.dEVIEND,
        this.gTGD,
        this.pERCENTCHANGE,
        this.uPDATEDTIME,
        this.cHANGE,
        this.cOLOR,
        this.kLGD,
        this.lASTPRICE,
        this.iNTERESTED,
        this.cHARTNOTIME,
        this.cATID,
        this.pERCENTRANGEPRICE,
        this.tOP30});

  StockIndustry.fromJson(Map<String, dynamic> json) {
    sTOCKCODE = json['STOCK_CODE'];
    vHTT = json['VHTT'];
    sTOCKNAME = json['STOCK_NAME'];
    iNDUSTRY = json['INDUSTRY'];
    sECONDINDUSTRY = json['SECOND_INDUSTRY'];
    dEVIEND = json['DEVIEND'];
    gTGD = json['GTGD'];
    pERCENTCHANGE = json['PERCENT_CHANGE'];
    uPDATEDTIME = json['UPDATED_TIME'];
    cHANGE = json['CHANGE'];
    cOLOR = json['COLOR'];
    kLGD = json['KLGD'];
    lASTPRICE = json['LAST_PRICE'];
    iNTERESTED = json['INTERESTED'];
    cHARTNOTIME = json['CHART_NO_TIME'];
    cATID = json['CATID'];
    pERCENTRANGEPRICE = json['PERCENT_RANGE_PRICE'];
    tOP30 = json['TOP30'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['STOCK_CODE'] = sTOCKCODE;
    data['VHTT'] = vHTT;
    data['STOCK_NAME'] = sTOCKNAME;
    data['INDUSTRY'] = iNDUSTRY;
    data['SECOND_INDUSTRY'] = sECONDINDUSTRY;
    data['DEVIEND'] = dEVIEND;
    data['GTGD'] = gTGD;
    data['PERCENT_CHANGE'] = pERCENTCHANGE;
    data['UPDATED_TIME'] = uPDATEDTIME;
    data['CHANGE'] = cHANGE;
    data['COLOR'] = cOLOR;
    data['KLGD'] = kLGD;
    data['LAST_PRICE'] = lASTPRICE;
    data['INTERESTED'] = iNTERESTED;
    data['CHART_NO_TIME'] = cHARTNOTIME;
    data['CATID'] = cATID;
    data['PERCENT_RANGE_PRICE'] = pERCENTRANGEPRICE;
    data['TOP30'] = tOP30;
    return data;
  }
}
