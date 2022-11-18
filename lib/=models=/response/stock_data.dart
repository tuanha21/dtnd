import 'package:dtnd/logic/stock_status.dart';

class StockData extends StockStatus {
  late final String sym;
  String? mc;
  num? c;
  num? f;
  num? r;
  num? lastPrice;
  num? lastVolume;
  num? lot;
  String? ot;
  num? changePc;
  num? avePrice;
  String? highPrice;
  String? lowPrice;
  String? fBVol;
  String? fBValue;
  String? fSVolume;
  String? fSValue;
  String? fRoom;
  String? g1;
  String? g2;
  String? g3;
  String? g4;
  String? g5;
  String? g6;
  String? g7;
  String? mp;

  num? get value {
    if (lot == null || !isValidAvePrice) {
      return 0;
    } else {
      return lot! * avePrice!;
    }
  }

  

  bool get isValidAvePrice {
    if (avePrice == null || c == null || f == null) {
      return false;
    }
    if ((avePrice! < f!) || (avePrice! > c!)) {
      return false;
    }
    return true;
  }

  @override
  SStatus get sstatus {
    try {
      if (lastPrice == null || r == null || c == null || f == null) {
        return SStatus.ref;
      }
      if (lastPrice! == r) {
        return SStatus.ref;
      }
      if (lastPrice! >= c!) {
        return SStatus.ceil;
      }
      if (lastPrice! <= f!) {
        return SStatus.floor;
      }
      if (lastPrice! > r!) {
        return SStatus.up;
      }
      if (lastPrice! < r!) {
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
    this.mp,
  });

  StockData.fromJson(Map<String, dynamic> json) {
    sym = json['sym'];
    mc = json['mc'];
    c = json['c'];
    f = json['f'];
    r = json['r'];
    lastPrice = json['lastPrice'];
    lastVolume = json['lastVolume'];
    lot = json['lot'];
    ot = json['ot'];
    changePc = num.parse(json['changePc']);
    avePrice = num.tryParse(json['avePrice']) ?? 0;
    highPrice = json['highPrice'];
    lowPrice = json['lowPrice'];
    fBVol = json['fBVol'];
    fBValue = json['fBValue'];
    fSVolume = json['fSVolume'];
    fSValue = json['fSValue'];
    fRoom = json['fRoom'];
    g1 = json['g1'];
    g2 = json['g2'];
    g3 = json['g3'];
    g4 = json['g4'];
    g5 = json['g5'];
    g6 = json['g6'];
    g7 = json['g7'];
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
