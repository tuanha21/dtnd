class SecurityBasicInfo {
  String? securityCode;
  String? exchangeCode;
  num? outstandingShares;
  num? marketCapital;
  num? totalVolume;
  num? totalValue;
  num? count10d;
  num? sumVol10d;
  num? volPerAVG10d;
  num? pE;
  num? pB;
  num? pS;
  num? ePS;
  num? rOA;
  num? rOE;
  String? industry;

  SecurityBasicInfo(
      {this.securityCode,
      this.exchangeCode,
      this.outstandingShares,
      this.marketCapital,
      this.totalVolume,
      this.totalValue,
      this.count10d,
      this.sumVol10d,
      this.volPerAVG10d,
      this.pE,
      this.pB,
      this.pS,
      this.ePS,
      this.rOA,
      this.rOE,
      this.industry});

  SecurityBasicInfo.fromJson(Map<String, dynamic> json) {
    securityCode = json['SecurityCode'];
    exchangeCode = json['ExchangeCode'];
    outstandingShares = json['OutstandingShares'];
    marketCapital = json['MarketCapital'];
    totalVolume = json['TotalVolume'];
    totalValue = json['TotalValue'];
    count10d = json['Count10d'];
    sumVol10d = json['SumVol10d'];
    volPerAVG10d = json['VolPerAVG10d'];
    pE = json['PE'];
    pB = json['PB'];
    pS = json['PS'];
    ePS = json['EPS'];
    rOA = json['ROA'];
    rOE = json['ROE'];
    industry = json['Industry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SecurityCode'] = securityCode;
    data['ExchangeCode'] = exchangeCode;
    data['OutstandingShares'] = outstandingShares;
    data['MarketCapital'] = marketCapital;
    data['TotalVolume'] = totalVolume;
    data['TotalValue'] = totalValue;
    data['Count10d'] = count10d;
    data['SumVol10d'] = sumVol10d;
    data['VolPerAVG10d'] = volPerAVG10d;
    data['PE'] = pE;
    data['PB'] = pB;
    data['PS'] = pS;
    data['EPS'] = ePS;
    data['ROA'] = rOA;
    data['ROE'] = rOE;
    data['Industry'] = industry;
    return data;
  }
}
