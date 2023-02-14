class StockBoard {
  num? sessionID;
  String? companyID;
  num? floorID;
  num? ceilingPrice;
  num? floorPrice;
  num? refPrice;
  num? buyPrice1;
  num? buyAmount1;
  num? buyPrice2;
  num? buyAmount2;
  num? buyPrice3;
  num? buyAmount3;
  num? sellPrice1;
  num? sellAmount1;
  num? sellPrice2;
  num? sellAmount2;
  num? sellPrice3;
  num? sellAmount3;
  num? finishPrice;
  num? finishAmount;
  num? diff;
  num? diffRate;
  num? price1;
  num? amount1;
  num? price2;
  num? amount2;
  String? benefit;
  String? meeting;
  num? highest;
  num? lowest;
  String? split;
  num? fGBuyQuantity;
  num? fGSellQuantity;
  num? pTMatchPrice;
  num? pTMatchQuantity;
  num? pTTotalMatchQuantity;
  num? pTTotalMatchValue;
  num? openPrice;
  num? closePrice;
  num? totalShare;
  num? totalValue;
  num? totalListingQuantity;
  num? remainRoom;
  num? remainRoomPCT;
  num? totalRoom;
  num? totalOfferQuantity;
  num? totalBidQuantity;
  num? averagePrice;
  num? averageVol;
  num? averageVolPercent;
  num? stockNo;
  num? stockType;
  num? offerCount;
  num? bidCount;
  num? remainBuyQtty;
  num? remainSellQtty;
  num? openInterest;
  String? lastTradingDate;
  num? diffVN30;
  num? basis;
  num? buyPrice4;
  num? buyAmount4;
  num? buyPrice5;
  num? buyAmount5;
  num? buyPrice6;
  num? buyAmount6;
  num? buyPrice7;
  num? buyAmount7;
  num? buyPrice8;
  num? buyAmount8;
  num? buyPrice9;
  num? buyAmount9;
  num? buyPrice10;
  num? buyAmount10;
  num? sellPrice4;
  num? sellAmount4;
  num? sellPrice5;
  num? sellAmount5;
  num? sellPrice6;
  num? sellAmount6;
  num? sellPrice7;
  num? sellAmount7;
  num? sellPrice8;
  num? sellAmount8;
  num? sellPrice9;
  num? sellAmount9;
  num? sellPrice10;
  num? sellAmount10;
  num? balancePrice;
  num? fGBuyValue;
  num? fGSellValue;
  num? fGNetQuantity;
  num? fGNetValue;
  String? checkSum;
  String? pTCheckSum;
  String? lECheckSum;
  String? fRoomCheckSum;
  String? updateTime;

  StockBoard(
      {this.sessionID,
        this.companyID,
        this.floorID,
        this.ceilingPrice,
        this.floorPrice,
        this.refPrice,
        this.buyPrice1,
        this.buyAmount1,
        this.buyPrice2,
        this.buyAmount2,
        this.buyPrice3,
        this.buyAmount3,
        this.sellPrice1,
        this.sellAmount1,
        this.sellPrice2,
        this.sellAmount2,
        this.sellPrice3,
        this.sellAmount3,
        this.finishPrice,
        this.finishAmount,
        this.diff,
        this.diffRate,
        this.price1,
        this.amount1,
        this.price2,
        this.amount2,
        this.benefit,
        this.meeting,
        this.highest,
        this.lowest,
        this.split,
        this.fGBuyQuantity,
        this.fGSellQuantity,
        this.pTMatchPrice,
        this.pTMatchQuantity,
        this.pTTotalMatchQuantity,
        this.pTTotalMatchValue,
        this.openPrice,
        this.closePrice,
        this.totalShare,
        this.totalValue,
        this.totalListingQuantity,
        this.remainRoom,
        this.remainRoomPCT,
        this.totalRoom,
        this.totalOfferQuantity,
        this.totalBidQuantity,
        this.averagePrice,
        this.averageVol,
        this.averageVolPercent,
        this.stockNo,
        this.stockType,
        this.offerCount,
        this.bidCount,
        this.remainBuyQtty,
        this.remainSellQtty,
        this.openInterest,
        this.lastTradingDate,
        this.diffVN30,
        this.basis,
        this.buyPrice4,
        this.buyAmount4,
        this.buyPrice5,
        this.buyAmount5,
        this.buyPrice6,
        this.buyAmount6,
        this.buyPrice7,
        this.buyAmount7,
        this.buyPrice8,
        this.buyAmount8,
        this.buyPrice9,
        this.buyAmount9,
        this.buyPrice10,
        this.buyAmount10,
        this.sellPrice4,
        this.sellAmount4,
        this.sellPrice5,
        this.sellAmount5,
        this.sellPrice6,
        this.sellAmount6,
        this.sellPrice7,
        this.sellAmount7,
        this.sellPrice8,
        this.sellAmount8,
        this.sellPrice9,
        this.sellAmount9,
        this.sellPrice10,
        this.sellAmount10,
        this.balancePrice,
        this.fGBuyValue,
        this.fGSellValue,
        this.fGNetQuantity,
        this.fGNetValue,
        this.checkSum,
        this.pTCheckSum,
        this.lECheckSum,
        this.fRoomCheckSum,
        this.updateTime});

  StockBoard.fromJson(Map<String, dynamic> json) {
    sessionID = json['SessionID'];
    companyID = json['CompanyID'];
    floorID = json['FloorID'];
    ceilingPrice = json['CeilingPrice'];
    floorPrice = json['FloorPrice'];
    refPrice = json['RefPrice'];
    buyPrice1 = json['BuyPrice1'];
    buyAmount1 = json['BuyAmount1'];
    buyPrice2 = json['BuyPrice2'];
    buyAmount2 = json['BuyAmount2'];
    buyPrice3 = json['BuyPrice3'];
    buyAmount3 = json['BuyAmount3'];
    sellPrice1 = json['SellPrice1'];
    sellAmount1 = json['SellAmount1'];
    sellPrice2 = json['SellPrice2'];
    sellAmount2 = json['SellAmount2'];
    sellPrice3 = json['SellPrice3'];
    sellAmount3 = json['SellAmount3'];
    finishPrice = json['FinishPrice'];
    finishAmount = json['FinishAmount'];
    diff = json['Diff'];
    diffRate = json['DiffRate'];
    price1 = json['Price1'];
    amount1 = json['Amount1'];
    price2 = json['Price2'];
    amount2 = json['Amount2'];
    benefit = json['Benefit'];
    meeting = json['Meeting'];
    highest = json['Highest'];
    lowest = json['Lowest'];
    split = json['Split'];
    fGBuyQuantity = json['FGBuyQuantity'];
    fGSellQuantity = json['FGSellQuantity'];
    pTMatchPrice = json['PTMatchPrice'];
    pTMatchQuantity = json['PTMatchQuantity'];
    pTTotalMatchQuantity = json['PTTotalMatchQuantity'];
    pTTotalMatchValue = json['PTTotalMatchValue'];
    openPrice = json['OpenPrice'];
    closePrice = json['ClosePrice'];
    totalShare = json['TotalShare'];
    totalValue = json['TotalValue'];
    totalListingQuantity = json['TotalListingQuantity'];
    remainRoom = json['RemainRoom'];
    remainRoomPCT = json['RemainRoomPCT'];
    totalRoom = json['TotalRoom'];
    totalOfferQuantity = json['TotalOfferQuantity'];
    totalBidQuantity = json['TotalBidQuantity'];
    averagePrice = json['AveragePrice'];
    averageVol = json['AverageVol'];
    averageVolPercent = json['AverageVolPercent'];
    stockNo = json['StockNo'];
    stockType = json['StockType'];
    offerCount = json['OfferCount'];
    bidCount = json['BidCount'];
    remainBuyQtty = json['RemainBuyQtty'];
    remainSellQtty = json['RemainSellQtty'];
    openInterest = json['OpenInterest'];
    lastTradingDate = json['LastTradingDate'];
    diffVN30 = json['DiffVN30'];
    basis = json['Basis'];
    buyPrice4 = json['BuyPrice4'];
    buyAmount4 = json['BuyAmount4'];
    buyPrice5 = json['BuyPrice5'];
    buyAmount5 = json['BuyAmount5'];
    buyPrice6 = json['BuyPrice6'];
    buyAmount6 = json['BuyAmount6'];
    buyPrice7 = json['BuyPrice7'];
    buyAmount7 = json['BuyAmount7'];
    buyPrice8 = json['BuyPrice8'];
    buyAmount8 = json['BuyAmount8'];
    buyPrice9 = json['BuyPrice9'];
    buyAmount9 = json['BuyAmount9'];
    buyPrice10 = json['BuyPrice10'];
    buyAmount10 = json['BuyAmount10'];
    sellPrice4 = json['SellPrice4'];
    sellAmount4 = json['SellAmount4'];
    sellPrice5 = json['SellPrice5'];
    sellAmount5 = json['SellAmount5'];
    sellPrice6 = json['SellPrice6'];
    sellAmount6 = json['SellAmount6'];
    sellPrice7 = json['SellPrice7'];
    sellAmount7 = json['SellAmount7'];
    sellPrice8 = json['SellPrice8'];
    sellAmount8 = json['SellAmount8'];
    sellPrice9 = json['SellPrice9'];
    sellAmount9 = json['SellAmount9'];
    sellPrice10 = json['SellPrice10'];
    sellAmount10 = json['SellAmount10'];
    balancePrice = json['BalancePrice'];
    fGBuyValue = json['FGBuyValue'];
    fGSellValue = json['FGSellValue'];
    fGNetQuantity = json['FGNetQuantity'];
    fGNetValue = json['FGNetValue'];
    checkSum = json['CheckSum'];
    pTCheckSum = json['PTCheckSum'];
    lECheckSum = json['LECheckSum'];
    fRoomCheckSum = json['FRoomCheckSum'];
    updateTime = json['UpdateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SessionID'] = sessionID;
    data['CompanyID'] = companyID;
    data['FloorID'] = floorID;
    data['CeilingPrice'] = ceilingPrice;
    data['FloorPrice'] = floorPrice;
    data['RefPrice'] = refPrice;
    data['BuyPrice1'] = buyPrice1;
    data['BuyAmount1'] = buyAmount1;
    data['BuyPrice2'] = buyPrice2;
    data['BuyAmount2'] = buyAmount2;
    data['BuyPrice3'] = buyPrice3;
    data['BuyAmount3'] = buyAmount3;
    data['SellPrice1'] = sellPrice1;
    data['SellAmount1'] = sellAmount1;
    data['SellPrice2'] = sellPrice2;
    data['SellAmount2'] = sellAmount2;
    data['SellPrice3'] = sellPrice3;
    data['SellAmount3'] = sellAmount3;
    data['FinishPrice'] = finishPrice;
    data['FinishAmount'] = finishAmount;
    data['Diff'] = diff;
    data['DiffRate'] = diffRate;
    data['Price1'] = price1;
    data['Amount1'] = amount1;
    data['Price2'] = price2;
    data['Amount2'] = amount2;
    data['Benefit'] = benefit;
    data['Meeting'] = meeting;
    data['Highest'] = highest;
    data['Lowest'] = lowest;
    data['Split'] = split;
    data['FGBuyQuantity'] = fGBuyQuantity;
    data['FGSellQuantity'] = fGSellQuantity;
    data['PTMatchPrice'] = pTMatchPrice;
    data['PTMatchQuantity'] = pTMatchQuantity;
    data['PTTotalMatchQuantity'] = pTTotalMatchQuantity;
    data['PTTotalMatchValue'] = pTTotalMatchValue;
    data['OpenPrice'] = openPrice;
    data['ClosePrice'] = closePrice;
    data['TotalShare'] = totalShare;
    data['TotalValue'] = totalValue;
    data['TotalListingQuantity'] = totalListingQuantity;
    data['RemainRoom'] = remainRoom;
    data['RemainRoomPCT'] = remainRoomPCT;
    data['TotalRoom'] = totalRoom;
    data['TotalOfferQuantity'] = totalOfferQuantity;
    data['TotalBidQuantity'] = totalBidQuantity;
    data['AveragePrice'] = averagePrice;
    data['AverageVol'] = averageVol;
    data['AverageVolPercent'] = averageVolPercent;
    data['StockNo'] = stockNo;
    data['StockType'] = stockType;
    data['OfferCount'] = offerCount;
    data['BidCount'] = bidCount;
    data['RemainBuyQtty'] = remainBuyQtty;
    data['RemainSellQtty'] = remainSellQtty;
    data['OpenInterest'] = openInterest;
    data['LastTradingDate'] = lastTradingDate;
    data['DiffVN30'] = diffVN30;
    data['Basis'] = basis;
    data['BuyPrice4'] = buyPrice4;
    data['BuyAmount4'] = buyAmount4;
    data['BuyPrice5'] = buyPrice5;
    data['BuyAmount5'] = buyAmount5;
    data['BuyPrice6'] = buyPrice6;
    data['BuyAmount6'] = buyAmount6;
    data['BuyPrice7'] = buyPrice7;
    data['BuyAmount7'] = buyAmount7;
    data['BuyPrice8'] = buyPrice8;
    data['BuyAmount8'] = buyAmount8;
    data['BuyPrice9'] = buyPrice9;
    data['BuyAmount9'] = buyAmount9;
    data['BuyPrice10'] = buyPrice10;
    data['BuyAmount10'] = buyAmount10;
    data['SellPrice4'] = sellPrice4;
    data['SellAmount4'] = sellAmount4;
    data['SellPrice5'] = sellPrice5;
    data['SellAmount5'] = sellAmount5;
    data['SellPrice6'] = sellPrice6;
    data['SellAmount6'] = sellAmount6;
    data['SellPrice7'] = sellPrice7;
    data['SellAmount7'] = sellAmount7;
    data['SellPrice8'] = sellPrice8;
    data['SellAmount8'] = sellAmount8;
    data['SellPrice9'] = sellPrice9;
    data['SellAmount9'] = sellAmount9;
    data['SellPrice10'] = sellPrice10;
    data['SellAmount10'] = sellAmount10;
    data['BalancePrice'] = balancePrice;
    data['FGBuyValue'] = fGBuyValue;
    data['FGSellValue'] = fGSellValue;
    data['FGNetQuantity'] = fGNetQuantity;
    data['FGNetValue'] = fGNetValue;
    data['CheckSum'] = checkSum;
    data['PTCheckSum'] = pTCheckSum;
    data['LECheckSum'] = lECheckSum;
    data['FRoomCheckSum'] = fRoomCheckSum;
    data['UpdateTime'] = updateTime;
    return data;
  }
}
