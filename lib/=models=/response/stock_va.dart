import 'package:dtnd/=models=/response/stock_model.dart';

class StockVa {
  int? rc;
  String? rs;
  String? oID;
  String? cmd;
  Data? data;

  @override
  String toString() {
    return 'StockVa{rc: $rc, rs: $rs, oID: $oID, cmd: $cmd, data: $data}';
  }

  StockVa({this.rc, this.rs, this.oID, this.cmd, this.data});

  StockVa.fromJson(Map<String, dynamic> json) {
    rc = json['rc'];
    rs = json['rs'];
    oID = json['oID'];
    cmd = json['cmd'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rc'] = rc;
    data['rs'] = rs;
    data['oID'] = oID;
    data['cmd'] = cmd;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? account;
  List<VAPortfolioModel>? stocks;

  Data({this.sId, this.account, this.stocks});

  @override
  String toString() {
    return 'Data{sId: $sId, account: $account, stocks: $stocks}';
  }

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    account = json['account'];
    if (json['stocks'] != null) {
      stocks = <VAPortfolioModel>[];
      json['stocks'].forEach((v) {
        stocks!.add(VAPortfolioModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['account'] = account;
    if (stocks != null) {
      data['stocks'] = stocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VAPortfolioModel {
  late final StockModel stockModel;
  String? sc;
  int? rrMax;
  double? buy;
  int? sell;
  int? volumeFix;
  int? volumePercent;

  @override
  String toString() {
    return 'Stocks{sc: $sc, rrMax: $rrMax, buy: $buy, sell: $sell, volumeFix: $volumeFix, volumePercent: $volumePercent}';
  }

  VAPortfolioModel.fromJson(Map<String, dynamic> json) {
    sc = json['sc'];
    rrMax = json['rrMax'];
    buy = json['buy'];
    sell = json['sell'];
    volumeFix = json['volumeFix'];
    volumePercent = json['volumePercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sc'] = sc;
    data['rrMax'] = rrMax;
    data['buy'] = buy;
    data['sell'] = sell;
    data['volumeFix'] = volumeFix;
    data['volumePercent'] = volumePercent;
    return data;
  }
}
