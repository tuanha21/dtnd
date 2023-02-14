class BasicCompany {
  String? securityCode;
  String? exchangeCode;
  String? firstListingDate;
  int? listedPrice;
  int? listedShares;
  int? outsShares;
  int? marketCap;
  String? level1NameVn;
  String? level2NameVn;
  String? level3NameVn;
  String? level4NameVn;
  String? level1NameEn;
  String? level2NameEn;
  String? level3NameEn;
  String? level4NameEn;

  BasicCompany(
      {this.securityCode,
        this.exchangeCode,
        this.firstListingDate,
        this.listedPrice,
        this.listedShares,
        this.outsShares,
        this.marketCap,
        this.level1NameVn,
        this.level2NameVn,
        this.level3NameVn,
        this.level4NameVn,
        this.level1NameEn,
        this.level2NameEn,
        this.level3NameEn,
        this.level4NameEn});

  BasicCompany.fromJson(Map<String, dynamic> json) {
    securityCode = json['securityCode'];
    exchangeCode = json['exchangeCode'];
    firstListingDate = json['firstListingDate'];
    listedPrice = json['listedPrice'];
    listedShares = json['listedShares'];
    outsShares = json['outsShares'];
    marketCap = json['marketCap'];
    level1NameVn = json['level1NameVn'];
    level2NameVn = json['level2NameVn'];
    level3NameVn = json['level3NameVn'];
    level4NameVn = json['level4NameVn'];
    level1NameEn = json['level1NameEn'];
    level2NameEn = json['level2NameEn'];
    level3NameEn = json['level3NameEn'];
    level4NameEn = json['level4NameEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['securityCode'] = securityCode;
    data['exchangeCode'] = exchangeCode;
    data['firstListingDate'] = firstListingDate;
    data['listedPrice'] = listedPrice;
    data['listedShares'] = listedShares;
    data['outsShares'] = outsShares;
    data['marketCap'] = marketCap;
    data['level1NameVn'] = level1NameVn;
    data['level2NameVn'] = level2NameVn;
    data['level3NameVn'] = level3NameVn;
    data['level4NameVn'] = level4NameVn;
    data['level1NameEn'] = level1NameEn;
    data['level2NameEn'] = level2NameEn;
    data['level3NameEn'] = level3NameEn;
    data['level4NameEn'] = level4NameEn;
    return data;
  }
}
