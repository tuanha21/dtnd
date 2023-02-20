import 'package:dtnd/=models=/core_response_model.dart';

class StockInfoCore implements CoreResponseModel {
  late final int id;
  late final String sym;
  num? c;
  num? f;
  num? r;
  num? lastPrice;
  num? lastVolume;
  num? lot;
  String? ot;
  String? cl;
  String? avePrice;
  String? highPrice;
  String? lowPrice;
  String? fRoom;
  String? g1;
  String? g2;
  String? g3;
  String? g4;
  String? g5;
  String? g6;
  String? g7;
  String? mc;
  String? mr;
  num? fBVol;
  num? fSVolume;
  num? stepPrice;
  String? code;
  String? stockType;
  String? statusInfo;
  String? forceUse;

  StockInfoCore(
      {required this.id,
      required this.sym,
      this.c,
      this.f,
      this.r,
      this.lastPrice,
      this.lastVolume,
      this.lot,
      this.ot,
      this.cl,
      this.avePrice,
      this.highPrice,
      this.lowPrice,
      this.fRoom,
      this.g1,
      this.g2,
      this.g3,
      this.g4,
      this.g5,
      this.g6,
      this.g7,
      this.mc,
      this.mr,
      this.fBVol,
      this.fSVolume,
      this.stepPrice,
      this.code,
      this.stockType,
      this.statusInfo,
      this.forceUse});

  StockInfoCore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sym = json['sym'];
    c = json['c'];
    f = json['f'];
    r = json['r'];
    lastPrice = json['lastPrice'];
    lastVolume = json['lastVolume'];
    lot = json['lot'];
    ot = json['ot'];
    cl = json['cl'];
    avePrice = json['avePrice'];
    highPrice = json['highPrice'];
    lowPrice = json['lowPrice'];
    fRoom = json['fRoom'];
    g1 = json['g1'];
    g2 = json['g2'];
    g3 = json['g3'];
    g4 = json['g4'];
    g5 = json['g5'];
    g6 = json['g6'];
    g7 = json['g7'];
    mc = json['mc'];
    mr = json['mr'];
    fBVol = json['fBVol'];
    fSVolume = json['fSVolume'];
    stepPrice = json['stepPrice'];
    code = json['code'];
    stockType = json['stockType'];
    statusInfo = json['status_info'];
    forceUse = json['force_use'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sym'] = sym;
    data['c'] = c;
    data['f'] = f;
    data['r'] = r;
    data['lastPrice'] = lastPrice;
    data['lastVolume'] = lastVolume;
    data['lot'] = lot;
    data['ot'] = ot;
    data['cl'] = cl;
    data['avePrice'] = avePrice;
    data['highPrice'] = highPrice;
    data['lowPrice'] = lowPrice;
    data['fRoom'] = fRoom;
    data['g1'] = g1;
    data['g2'] = g2;
    data['g3'] = g3;
    data['g4'] = g4;
    data['g5'] = g5;
    data['g6'] = g6;
    data['g7'] = g7;
    data['mc'] = mc;
    data['mr'] = mr;
    data['fBVol'] = fBVol;
    data['fSVolume'] = fSVolume;
    data['stepPrice'] = stepPrice;
    data['code'] = code;
    data['stockType'] = stockType;
    data['status_info'] = statusInfo;
    data['force_use'] = forceUse;
    return data;
  }
}
