class StockHis {
  num? row;
  String? stockCode;
  String? tradingDate;
  num? closePrice;
  num? basicPrice;
  num? ceilingPrice;
  num? floorPrice;
  num? openPrice;
  num? highestPrice;
  num? lowestPrice;
  num? lastPrice;
  num? avrPrice;
  num? totalVol;
  num? totalVal;
  num? marketCapital;
  num? change;
  num? perChange;
  num? colorID;
  String? exchange;
  num? rows;

  DateTime? get dateTime {
    return DateTime.tryParse(tradingDate!);
  }

  StockHis(
      {this.row,
      this.stockCode,
      this.tradingDate,
      this.closePrice,
      this.basicPrice,
      this.ceilingPrice,
      this.floorPrice,
      this.openPrice,
      this.highestPrice,
      this.lowestPrice,
      this.lastPrice,
      this.avrPrice,
      this.totalVol,
      this.totalVal,
      this.marketCapital,
      this.change,
      this.perChange,
      this.colorID,
      this.exchange,
      this.rows});

  StockHis.fromJson(Map<String, dynamic> json) {
    row = json['Row'];
    stockCode = json['StockCode'];
    tradingDate = json['TradingDate'];
    closePrice = json['ClosePrice'];
    basicPrice = json['BasicPrice'];
    ceilingPrice = json['CeilingPrice'];
    floorPrice = json['FloorPrice'];
    openPrice = json['OpenPrice'];
    highestPrice = json['HighestPrice'];
    lowestPrice = json['LowestPrice'];
    lastPrice = json['LastPrice'];
    avrPrice = json['AvrPrice'];
    totalVol = json['TotalVol'];
    totalVal = json['TotalVal'];
    marketCapital = json['MarketCapital'];
    change = json['Change'];
    perChange = json['PerChange'];
    colorID = json['ColorID'];
    exchange = json['Exchange'];
    rows = json['Rows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Row'] = row;
    data['StockCode'] = stockCode;
    data['TradingDate'] = tradingDate;
    data['ClosePrice'] = closePrice;
    data['BasicPrice'] = basicPrice;
    data['CeilingPrice'] = ceilingPrice;
    data['FloorPrice'] = floorPrice;
    data['OpenPrice'] = openPrice;
    data['HighestPrice'] = highestPrice;
    data['LowestPrice'] = lowestPrice;
    data['LastPrice'] = lastPrice;
    data['AvrPrice'] = avrPrice;
    data['TotalVol'] = totalVol;
    data['TotalVal'] = totalVal;
    data['MarketCapital'] = marketCapital;
    data['Change'] = change;
    data['PerChange'] = perChange;
    data['ColorID'] = colorID;
    data['Exchange'] = exchange;
    data['Rows'] = rows;
    return data;
  }
}
