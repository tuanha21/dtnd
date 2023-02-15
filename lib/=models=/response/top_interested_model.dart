class TopInterested {
  late final String sTOCKCODE;
  int? kLGD;
  int? gTGD;
  String? sTOCKNAME;
  double? cHANGE;
  double? pERCENTCHANGE;
  String? cOLOR;
  List<num>? cHART;
  double? pRICE;

  TopInterested(
      {required this.sTOCKCODE,
      this.kLGD,
      this.gTGD,
      this.sTOCKNAME,
      this.cHANGE,
      this.pERCENTCHANGE,
      this.cOLOR,
      this.cHART,
      this.pRICE});

  TopInterested.fromJson(Map<String, dynamic> json) {
    sTOCKCODE = json['STOCK_CODE'];
    kLGD = json['KLGD'];
    gTGD = json['GTGD'];
    sTOCKNAME = json['STOCK_NAME'];
    cHANGE = json['CHANGE'];
    pERCENTCHANGE = json['PERCENT_CHANGE'];
    cOLOR = json['COLOR'];
    List<String> list = (json['CHART'] as String)
        .replaceAll("[", "")
        .replaceAll("]", "")
        .split(",");
    cHART = list.map((e) => num.tryParse(e) ?? 0).toList();
    pRICE = json['PRICE'];
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
}
