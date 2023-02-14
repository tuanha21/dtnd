class StockMatch {
  num? matchPrice;
  num? buyActiveQtty;
  num? sellActiveQtty;
  num? noneActiveQtty;

  num get totalVol {
    num total = 0;
    if (buyActiveQtty != null) total += buyActiveQtty!;
    if (sellActiveQtty != null) total += sellActiveQtty!;
    if (noneActiveQtty != null) total += noneActiveQtty!;
    return total;
  }

  StockMatch(
      {this.matchPrice,
      this.buyActiveQtty,
      this.sellActiveQtty,
      this.noneActiveQtty});

  StockMatch.fromJson(Map<String, dynamic> json) {
    matchPrice = json['MatchPrice'];
    buyActiveQtty = json['BuyActiveQtty'];
    sellActiveQtty = json['SellActiveQtty'];
    noneActiveQtty = json['NoneActiveQtty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MatchPrice'] = matchPrice;
    data['BuyActiveQtty'] = buyActiveQtty;
    data['SellActiveQtty'] = sellActiveQtty;
    data['NoneActiveQtty'] = noneActiveQtty;
    return data;
  }
}
