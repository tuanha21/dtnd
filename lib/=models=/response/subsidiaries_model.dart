class BusinessSubsidiariesModel {
  List<SubsidiariesModel>? subsidiaries;
  List<SubsidiariesModel>? associatedCompany;
  List<SubsidiariesModel>? other;

  BusinessSubsidiariesModel(
      {this.subsidiaries, this.associatedCompany, this.other});
}

class SubsidiariesModel {
  String? ticker;
  String? relatedCompanyName;
  num? charterCapital;
  num? ownerShip;

  SubsidiariesModel(
      {this.ticker,
      this.relatedCompanyName,
      this.charterCapital,
      this.ownerShip});

  SubsidiariesModel.fromJson(Map<String, dynamic> json) {
    ticker = json['ticker'];
    relatedCompanyName = json['relatedCompanyName'];
    charterCapital = json['charterCapital'];
    ownerShip = json['ownerShip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticker'] = ticker;
    data['relatedCompanyName'] = relatedCompanyName;
    data['charterCapital'] = charterCapital;
    data['ownerShip'] = ownerShip;
    return data;
  }
}
