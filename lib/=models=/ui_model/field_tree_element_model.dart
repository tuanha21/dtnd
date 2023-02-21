import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class FieldTreeModel {
  late final String iNDUSTRY;
  late final num tOTALKLGD;
  final List<FieldTreeElementModel> stocks = [];

  FieldTreeModel(
      {required this.iNDUSTRY,
      required this.tOTALKLGD,
      required List<FieldTreeElementModel> list}) {
    stocks.addAll(list);
  }

  FieldTreeModel.fromJson(Map<String, dynamic> json) {
    iNDUSTRY = json['INDUSTRY'];
    tOTALKLGD = json['TOTAL_KLGD'] ?? (json['TOTAL_GTGD'] ?? 0);
    if (json['stocks'] != null) {
      stocks.clear();
      json['stocks'].forEach((v) {
        stocks.add(FieldTreeElementModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['INDUSTRY'] = iNDUSTRY;
    data['TOTAL_KLGD'] = tOTALKLGD;
    if (stocks.isNotEmpty) {
      data['stocks'] = stocks.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    return other is FieldTreeModel && other.iNDUSTRY == iNDUSTRY;
  }

  @override
  int get hashCode => iNDUSTRY.hashCode;
}

class FieldTreeElementModel {
  late final Stock stock;
  String? sTOCKCODE;
  num? vHTT;
  String? sTOCKNAME;
  String? iNDUSTRY;
  String? sECONDINDUSTRY;
  num? kLGD;
  num? lASTPRICE;
  num? gTGD;
  num? pERCENTCHANGE;
  num? cHANGE;
  String? cOLOR;
  // num? dEVIEND;
  // num? uPDATEDTIME;
  // String? qEPS;
  // String? qPE;
  // String? qPB;
  // String? qROE;
  // String? qROA;
  // num? iNTERESTED;
  // String? cHARTNOTIME;
  // String? cATID;

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

  FieldTreeElementModel({
    this.sTOCKCODE,
    this.vHTT,
    this.sTOCKNAME,
    this.iNDUSTRY,
    this.sECONDINDUSTRY,
    this.gTGD,
    this.kLGD,
    this.pERCENTCHANGE,
    this.lASTPRICE,
    this.cHANGE,
    this.cOLOR,
    // this.uPDATEDTIME,
    // this.qEPS,
    // this.qPE,
    // this.qPB,
    // this.qROE,
    // this.qROA,
    // this.dEVIEND,
    // this.iNTERESTED,
    // this.cHARTNOTIME,
    // this.cATID,
  });

  void getStock(IDataCenterService dataCenterService) {
    stock = dataCenterService.getStocksBySym(sTOCKCODE!)!;
  }

  FieldTreeElementModel.fromJson(Map<String, dynamic> json) {
    sTOCKCODE = json['STOCK_CODE'];
    vHTT = json['VHTT'];
    sTOCKNAME = json['STOCK_NAME'];
    iNDUSTRY = json['INDUSTRY'];
    sECONDINDUSTRY = json['SECOND_INDUSTRY'];
    gTGD = (json['GTGD'] ?? 0);
    pERCENTCHANGE = json['PERCENT_CHANGE'];
    cHANGE = json['CHANGE'];
    cOLOR = json['COLOR'];
    kLGD = json['KLGD'];
    lASTPRICE = json['LAST_PRICE'];
    // iNTERESTED = json['INTERESTED'];
    // cHARTNOTIME = json['CHART_NO_TIME'];
    // dEVIEND = json['DEVIEND'];
    // uPDATEDTIME = json['UPDATED_TIME'];
    // cATID = json['CATID'];
    // qEPS = json['Q_EPS'];
    // qPE = json['Q_PE'];
    // qPB = json['Q_PB'];
    // qROE = json['Q_ROE'];
    // qROA = json['Q_ROA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['STOCK_CODE'] = sTOCKCODE;
    data['VHTT'] = vHTT;
    data['STOCK_NAME'] = sTOCKNAME;
    data['INDUSTRY'] = iNDUSTRY;
    data['SECOND_INDUSTRY'] = sECONDINDUSTRY;
    data['LAST_PRICE'] = lASTPRICE;
    data['GTGD'] = gTGD;
    data['KLGD'] = kLGD;
    data['PERCENT_CHANGE'] = pERCENTCHANGE;
    data['CHANGE'] = cHANGE;
    data['COLOR'] = cOLOR;
    // data['Q_EPS'] = qEPS;
    // data['Q_PE'] = qPE;
    // data['Q_PB'] = qPB;
    // data['Q_ROE'] = qROE;
    // data['Q_ROA'] = qROA;
    // data['UPDATED_TIME'] = uPDATEDTIME;
    // data['INTERESTED'] = iNTERESTED;
    // data['CHART_NO_TIME'] = cHARTNOTIME;
    // data['CATID'] = cATID;
    // data['DEVIEND'] = dEVIEND;
    return data;
  }
}
