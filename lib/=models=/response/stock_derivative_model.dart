import 'package:flutter/material.dart';
import 'package:dtnd/ui/theme/app_color.dart';

class DerivativeResModel {
  late final int? id;
  late final String? sym;
  String? mc;
  num? c;
  num? f;
  num? r;
  num? lastPrice;
  num? lastVolume;
  num? lot;
  String? avePrice;
  String? highPrice;
  String? lowPrice;
  String? fBVol;
  String? fBValue;
  String? fSVolume;
  String? fSValue;
  String? g1;
  String? g2;
  String? g3;
  String? g4;
  String? g5;
  String? g6;
  String? g7;
  String? mkStatus;
  String? listingStatus;
  String? matureDate;
  String? closePrice;
  String? ptVol;
  String? oi;
  String? oichange;
  num? lv;
  num? openPrice;

  DerivativeResModel(
      {required this.id,
      required this.sym,
      this.mc,
      this.c,
      this.f,
      this.r,
      this.lastPrice,
      this.lastVolume,
      this.lot,
      this.avePrice,
      this.highPrice,
      this.lowPrice,
      this.fBVol,
      this.fBValue,
      this.fSVolume,
      this.fSValue,
      this.g1,
      this.g2,
      this.g3,
      this.g4,
      this.g5,
      this.g6,
      this.g7,
      this.mkStatus,
      this.listingStatus,
      this.matureDate,
      this.closePrice,
      this.ptVol,
      this.oi,
      this.oichange,
      this.lv,
      this.openPrice});

  DerivativeResModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sym = json['sym'];
    mc = json['mc'];
    c = json['c'];
    f = json['f'];
    r = json['r'];
    lastPrice = json['lastPrice'];
    lastVolume = json['lastVolume'];
    lot = json['lot'];
    avePrice = json['avePrice'];
    highPrice = json['highPrice'];
    lowPrice = json['lowPrice'];
    fBVol = json['fBVol'];
    fBValue = json['fBValue'];
    fSVolume = json['fSVolume'];
    fSValue = json['fSValue'];
    g1 = json['g1'];
    g2 = json['g2'];
    g3 = json['g3'];
    g4 = json['g4'];
    g5 = json['g5'];
    g6 = json['g6'];
    g7 = json['g7'];
    mkStatus = json['mkStatus'];
    listingStatus = json['listing_status'];
    matureDate = json['matureDate'];
    closePrice = json['closePrice'];
    ptVol = json['ptVol'];
    oi = json['oi'];
    oichange = json['oichange'];
    lv = json['lv'];
    openPrice = json['openPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sym'] = this.sym;
    data['mc'] = this.mc;
    data['c'] = this.c;
    data['f'] = this.f;
    data['r'] = this.r;
    data['lastPrice'] = this.lastPrice;
    data['lastVolume'] = this.lastVolume;
    data['lot'] = this.lot;
    data['avePrice'] = this.avePrice;
    data['highPrice'] = this.highPrice;
    data['lowPrice'] = this.lowPrice;
    data['fBVol'] = this.fBVol;
    data['fBValue'] = this.fBValue;
    data['fSVolume'] = this.fSVolume;
    data['fSValue'] = this.fSValue;
    data['g1'] = this.g1;
    data['g2'] = this.g2;
    data['g3'] = this.g3;
    data['g4'] = this.g4;
    data['g5'] = this.g5;
    data['g6'] = this.g6;
    data['g7'] = this.g7;
    data['mkStatus'] = this.mkStatus;
    data['listing_status'] = this.listingStatus;
    data['matureDate'] = this.matureDate;
    data['closePrice'] = this.closePrice;
    data['ptVol'] = this.ptVol;
    data['oi'] = this.oi;
    data['oichange'] = this.oichange;
    data['lv'] = this.lv;
    data['openPrice'] = this.openPrice;
    return data;
  }

  Color getPriceColor(num price) {
    if (price <= 0 || c == null || r == null || f == null) {
      return AppColors.semantic_02;
    }
    if (c == 0 || r == 0 || f == 0 || price == r) {
      return AppColors.semantic_02;
    }
    if (price <= f!) {
      return AppColors.semantic_04;
    }
    if (price >= c!) {
      return AppColors.semantic_05;
    }

    if (price < r!) {
      return AppColors.semantic_03;
    }
    if (price > r!) {
      return AppColors.semantic_01;
    }
    return AppColors.semantic_02;
  }
}
