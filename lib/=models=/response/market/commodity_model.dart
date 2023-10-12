import 'package:dtnd/=models=/stock_status.dart';

class CommodityModel extends StockStatus {
  late final String nAME;
  String? lASTPRICE;
  String? pOINTCHANGE;
  String? pERCENTCHANGE;
  String? cOLOR;

  CommodityModel.fromJson(Map<String, dynamic> json) {
    nAME = json['NAME'];
    lASTPRICE = json['LAST_PRICE'];
    pOINTCHANGE = json['POINT_CHANGE'];
    pERCENTCHANGE = json['PERCENT_CHANGE'];
    cOLOR = json['COLOR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NAME'] = nAME;
    data['LAST_PRICE'] = lASTPRICE;
    data['POINT_CHANGE'] = pOINTCHANGE;
    data['PERCENT_CHANGE'] = pERCENTCHANGE;
    data['COLOR'] = cOLOR;
    return data;
  }

  @override
  SStatus get sstatus {
    switch (cOLOR) {
      case "green":
        return SStatus.up;
      case "red":
        return SStatus.down;
      default:
        return SStatus.ref;
    }
  }

  @override
  operator ==(Object other) {
    return identical(this, other) ||
        other is CommodityModel && other.nAME == nAME;
  }

  @override
  int get hashCode => nAME.hashCode;
}
