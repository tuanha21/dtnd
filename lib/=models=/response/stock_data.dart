import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/logic/stock_status.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockData extends StockStatus {
  late final String sym;
  late final String? mc;
  final Rx<num?> c = Rxn();
  final Rx<num?> f = Rxn();
  final Rx<num?> r = Rxn();
  final Rx<num?> lastPrice = Rxn();
  final Rx<num?> lastVolume = Rxn();
  final Rx<num?> lot = Rxn();
  final Rx<num?> ot = Rxn();
  final Rx<num?> changePc = Rxn();
  final Rx<num?> avePrice = Rxn();
  final Rx<num?> highPrice = Rxn();
  final Rx<num?> lowPrice = Rxn();
  final Rx<num?> fBVol = Rxn();
  final Rx<num?> fBValue = Rxn();
  final Rx<num?> fSVolume = Rxn();
  final Rx<num?> fSValue = Rxn();
  final Rx<num?> fRoom = Rxn();
  final Rx<String?> g1 = Rxn();
  final Rx<String?> g2 = Rxn();
  final Rx<String?> g3 = Rxn();
  final Rx<String?> g4 = Rxn();
  final Rx<String?> g5 = Rxn();
  final Rx<String?> g6 = Rxn();
  final Rx<String?> g7 = Rxn();
  String? mp;

  num? get value {
    if (lot.value == null || !isValidAvePrice) {
      return 0;
    } else {
      return lot.value! * avePrice.value!;
    }
  }

  bool get isValidAvePrice {
    if (avePrice.value == null || c.value == null || f.value == null) {
      return false;
    }
    if ((avePrice.value! < f.value!) || (avePrice.value! > c.value!)) {
      return false;
    }
    return true;
  }

  num getTotalVol(Side side) {
    try {
      switch (side) {
        case Side.buy:
          final g1Vol =
              num.tryParse(g1.value?.split("|").elementAt(1) ?? "0") ?? 0;
          final g2Vol =
              num.tryParse(g2.value?.split("|").elementAt(1) ?? "0") ?? 0;
          final g3Vol =
              num.tryParse(g3.value?.split("|").elementAt(1) ?? "0") ?? 0;
          return g1Vol + g2Vol + g3Vol;
        case Side.sell:
          final g1Vol =
              num.tryParse(g4.value?.split("|").elementAt(1) ?? "0") ?? 0;
          final g2Vol =
              num.tryParse(g5.value?.split("|").elementAt(1) ?? "0") ?? 0;
          final g3Vol =
              num.tryParse(g6.value?.split("|").elementAt(1) ?? "0") ?? 0;
          return g1Vol + g2Vol + g3Vol;
      }
    } catch (e) {
      logger.v(e);
      return 0;
    }
  }

  Color getPriceColor(num price) {
    if (price <= 0 || c.value == null || r.value == null || f.value == null) {
      return AppColors.semantic_02;
    }
    if (c.value == 0 || r.value == 0 || f.value == 0 || price == r.value) {
      return AppColors.semantic_02;
    }
    if (price <= f.value!) {
      return AppColors.semantic_04;
    }
    if (price >= c.value!) {
      return AppColors.semantic_05;
    }

    if (price < r.value!) {
      return AppColors.semantic_03;
    }
    if (price > r.value!) {
      return AppColors.semantic_01;
    }
    return AppColors.semantic_02;
  }

  @override
  SStatus get sstatus {
    try {
      if (lastPrice.value == null ||
          r.value == null ||
          c.value == null ||
          f.value == null) {
        return SStatus.ref;
      }
      if (lastPrice.value! == r.value) {
        return SStatus.ref;
      }
      if (lastPrice.value! >= c.value!) {
        return SStatus.ceil;
      }
      if (lastPrice.value! <= f.value!) {
        return SStatus.floor;
      }
      if (lastPrice.value! > r.value!) {
        return SStatus.up;
      }
      if (lastPrice.value! < r.value!) {
        return SStatus.down;
      }
      return SStatus.ref;
    } catch (e) {
      return SStatus.ref;
    }
  }

  StockData({
    required this.sym,
    this.mc,
    num? c,
    num? f,
    num? r,
    num? lastPrice,
    num? lastVolume,
    num? lot,
    num? ot,
    num? changePc,
    num? avePrice,
    num? highPrice,
    num? lowPrice,
    num? fBVol,
    num? fBValue,
    num? fSVolume,
    num? fSValue,
    num? fRoom,
    String? g1,
    String? g2,
    String? g3,
    String? g4,
    String? g5,
    String? g6,
    String? g7,
    this.mp,
  }) {
    this.c.value = c;
    this.f.value = f;
    this.r.value = r;
    this.lastPrice.value = lastPrice;
    this.lastVolume.value = lastVolume;
    this.lot.value = lot;
    this.ot.value = ot;
    this.changePc.value = changePc;
    this.avePrice.value = avePrice;
    this.g1.value = g1;
    this.g2.value = g2;
    this.g3.value = g3;
    this.g4.value = g4;
    this.g5.value = g5;
    this.g6.value = g6;
    this.g7.value = g7;
  }

  StockData.fromResponse(StockDataResponse response) {
    sym = response.sym;
    r.value = response.r;
    c.value = response.c;
    f.value = response.f;
    lastPrice.value = response.lastPrice;
    lastVolume.value = response.lastVolume;
    lot.value = response.lot;
    ot.value = response.ot;
    changePc.value = response.changePc;
    avePrice.value = response.avePrice;
    highPrice.value = response.highPrice;
    lowPrice.value = response.lowPrice;
    fBVol.value = response.fBVol;
    fBValue.value = response.fBValue;
    fSVolume.value = response.fSVolume;
    fSValue.value = response.fSValue;
    fRoom.value = response.fRoom;
    g1.value = response.g1;
    g2.value = response.g2;
    g3.value = response.g3;
    g4.value = response.g4;
    g5.value = response.g5;
    g6.value = response.g6;
    g7.value = response.g7;
  }

  StockData.getDefault(String stockCode) {
    sym = stockCode;
  }

  StockData.fromJson(Map<String, dynamic> json) {
    sym = json['sym'];
    mc = json['mc'];
    c.value = json['c'];
    f.value = json['f'];
    r.value = json['r'];
    lastPrice.value = json['lastPrice'];
    lastVolume.value = json['lastVolume'];
    lot.value = json['lot'];
    ot.value = num.parse(json['ot']);
    changePc.value = num.parse(json['changePc']);
    avePrice.value = num.tryParse(json['avePrice']) ?? 0;
    highPrice.value = num.tryParse(json['highPrice']) ?? 0;
    lowPrice.value = num.tryParse(json['lowPrice']) ?? 0;
    fBVol.value = num.tryParse(json['fBVol']) ?? 0;
    fBValue.value = num.tryParse(json['fBValue']) ?? 0;
    fSVolume.value = num.tryParse(json['fSVolume']) ?? 0;
    fSValue.value = num.tryParse(json['fSValue']) ?? 0;
    fRoom.value = num.tryParse(json['fRoom']) ?? 0;
    g1.value = json['g1'];
    g2.value = json['g2'];
    g3.value = json['g3'];
    g4.value = json['g4'];
    g5.value = json['g5'];
    g6.value = json['g6'];
    g7.value = json['g7'];
    mp = json['mp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sym'] = sym;
    data['mc'] = mc;
    data['c'] = c;
    data['f'] = f;
    data['r'] = r;
    data['lastPrice'] = lastPrice;
    data['lastVolume'] = lastVolume;
    data['lot'] = lot;
    data['ot'] = ot;
    data['changePc'] = changePc;
    data['avePrice'] = avePrice;
    data['highPrice'] = highPrice;
    data['lowPrice'] = lowPrice;
    data['fBVol'] = fBVol;
    data['fBValue'] = fBValue;
    data['fSVolume'] = fSVolume;
    data['fSValue'] = fSValue;
    data['fRoom'] = fRoom;
    data['g1'] = g1;
    data['g2'] = g2;
    data['g3'] = g3;
    data['g4'] = g4;
    data['g5'] = g5;
    data['g6'] = g6;
    data['g7'] = g7;
    data['mp'] = mp;
    return data;
  }
}

class StockDataResponse {
  num? id;
  late final String sym;
  String? mc;
  num? c;
  num? f;
  num? r;
  num? lastPrice;
  num? lastVolume;
  num? lot;
  num? ot;
  num? changePc;
  num? avePrice;
  num? highPrice;
  num? lowPrice;
  num? fBVol;
  num? fBValue;
  num? fSVolume;
  num? fSValue;
  num? fRoom;
  String? g1;
  String? g2;
  String? g3;
  String? g4;
  String? g5;
  String? g6;
  String? g7;
  String? mp;

  StockDataResponse(
      {this.id,
      required this.sym,
      this.mc,
      this.c,
      this.f,
      this.r,
      this.lastPrice,
      this.lastVolume,
      this.lot,
      this.ot,
      this.changePc,
      this.avePrice,
      this.highPrice,
      this.lowPrice,
      this.fBVol,
      this.fBValue,
      this.fSVolume,
      this.fSValue,
      this.fRoom,
      this.g1,
      this.g2,
      this.g3,
      this.g4,
      this.g5,
      this.g6,
      this.g7,
      this.mp});

  StockDataResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sym = json['sym'];
    mc = json['mc'];
    c = json['c'];
    f = json['f'];
    r = json['r'];
    lastPrice = json['lastPrice'];
    lastVolume = json['lastVolume'];
    lot = json['lot'];
    ot = num.parse(json['ot']);
    changePc = num.parse(json['changePc']);
    avePrice = num.tryParse(json['avePrice']) ?? 0;
    highPrice = num.tryParse(json['highPrice']) ?? 0;
    lowPrice = num.tryParse(json['lowPrice']) ?? 0;
    fBVol = num.tryParse(json['fBVol']) ?? 0;
    fBValue = num.tryParse(json['fBValue']) ?? 0;
    fSVolume = num.tryParse(json['fSVolume']) ?? 0;
    fSValue = num.tryParse(json['fSValue']) ?? 0;
    fRoom = num.tryParse(json['fRoom']) ?? 0;
    g1 = json['g1'];
    g2 = json['g2'];
    g3 = json['g3'];
    g4 = json['g4'];
    g5 = json['g5'];
    g6 = json['g6'];
    g7 = json['g7'];
    mp = json['mp'];
  }
}
