import 'dart:ui';

import 'package:dtnd/logic/stock_status.dart';

class TrashModel extends StockStatus {
  late final String sTOCKCODE;
  late final num kLGD;
  num? gTGD;
  String? sTOCKNAME;
  num? cHANGE;
  num? pERCENTCHANGE;
  late final String cOLOR;
  List<num>? cHART;
  num? pRICE;

  TrashModel.fromJson(Map<String, dynamic> json) {
    sTOCKCODE = json['STOCK_CODE'];
    kLGD = (json['KLGD'] ?? 0);
    gTGD = json['GTGD'];
    sTOCKNAME = json['STOCK_NAME'];
    cHANGE = json['CHANGE'];
    pERCENTCHANGE = json['PERCENT_CHANGE'];
    cOLOR = json['COLOR'] ?? "yellow";
    List<String> list = (json['CHART'] as String)
        .replaceAll("[", "")
        .replaceAll("]", "")
        .split(",");
    cHART = list.map((e) => num.tryParse(e) ?? 0).toList();
    pRICE = json['PRICE'] ?? json['LAST_PRICE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['STOCK_CODE'] = sTOCKCODE;
    data['KLGD'] = kLGD;
    data['GTGD'] = gTGD;
    data['STOCK_NAME'] = sTOCKNAME;
    data['CHANGE'] = cHANGE;
    data['PERCENT_CHANGE'] = pERCENTCHANGE;
    data['COLOR'] = cOLOR;
    data['CHART'] = cHART;
    data['PRICE'] = pRICE;
    return data;
  }

  @override
  SStatus get sstatus {
    switch (cOLOR) {
      case "green":
        return SStatus.up;
      case "red":
        return SStatus.down;
      case "violet":
        return SStatus.ceil;
      case "blue":
        return SStatus.floor;
      default:
        return SStatus.ref;
    }
  }
}
