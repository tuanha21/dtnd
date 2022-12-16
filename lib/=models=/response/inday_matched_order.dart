class IndayMatchedOrder {
  late final String time;
  late final num matchPrice;
  late final num priceChange;
  late final num matchVolume;
  late final num totalVolume;
  late final num buyPct1;
  late final String orderType;
  late final num buyPct;
  late final num sellPct;
  late final num nAPct;
  late final num totalBuyVolume;
  late final num totalSellVolume;
  late final num buyForeignQtty;
  late final num buyForeignValue;

  IndayMatchedOrder({
    required this.time,
    required this.matchPrice,
    required this.priceChange,
    required this.matchVolume,
    required this.totalVolume,
    required this.buyPct1,
    required this.orderType,
    required this.buyPct,
    required this.sellPct,
    required this.nAPct,
    required this.totalBuyVolume,
    required this.totalSellVolume,
    required this.buyForeignQtty,
    required this.buyForeignValue,
  });

  IndayMatchedOrder.fromJson(Map<String, dynamic> json) {
    time = json['Time'];
    matchPrice = json['MatchPrice'];
    priceChange = json['PriceChange'];
    matchVolume = json['MatchVolume'];
    totalVolume = json['TotalVolume'];
    buyPct1 = json['BuyPct1'];
    orderType = json['OrderType'];
    buyPct = json['BuyPct'];
    sellPct = json['SellPct'];
    nAPct = json['NAPct'];
    totalBuyVolume = json['TotalBuyVolume'];
    totalSellVolume = json['TotalSellVolume'];
    buyForeignQtty = json['BuyForeignQtty'];
    buyForeignValue = json['BuyForeignValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Time'] = time;
    data['MatchPrice'] = matchPrice;
    data['PriceChange'] = priceChange;
    data['MatchVolume'] = matchVolume;
    data['TotalVolume'] = totalVolume;
    data['BuyPct1'] = buyPct1;
    data['OrderType'] = orderType;
    data['BuyPct'] = buyPct;
    data['SellPct'] = sellPct;
    data['NAPct'] = nAPct;
    data['TotalBuyVolume'] = totalBuyVolume;
    data['TotalSellVolume'] = totalSellVolume;
    data['BuyForeignQtty'] = buyForeignQtty;
    data['BuyForeignValue'] = buyForeignValue;
    return data;
  }
}
