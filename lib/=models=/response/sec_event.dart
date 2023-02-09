class SecEvent {
  String? eFFECTIVEDATE;
  String? eVENTDESCJP;
  String? eVENTDATE;
  String? lASTREGDATE;
  String? eVENTDESC;
  String? eXDATE;
  String? eVENTDESCCN;
  String? sECURITYCODE;
  String? eVENTDESCEN;
  String? aNNOUNCEDDATE;
  String? eVENTDESCKR;

  SecEvent(
      {this.eFFECTIVEDATE,
        this.eVENTDESCJP,
        this.eVENTDATE,
        this.lASTREGDATE,
        this.eVENTDESC,
        this.eXDATE,
        this.eVENTDESCCN,
        this.sECURITYCODE,
        this.eVENTDESCEN,
        this.aNNOUNCEDDATE,
        this.eVENTDESCKR});

  SecEvent.fromJson(Map<String, dynamic> json) {
    eFFECTIVEDATE = json['EFFECTIVE_DATE'];
    eVENTDESCJP = json['EVENT_DESC_JP'];
    eVENTDATE = json['EVENT_DATE'];
    lASTREGDATE = json['LAST_REG_DATE'];
    eVENTDESC = json['EVENT_DESC'];
    eXDATE = json['EX_DATE'];
    eVENTDESCCN = json['EVENT_DESC_CN'];
    sECURITYCODE = json['SECURITY_CODE'];
    eVENTDESCEN = json['EVENT_DESC_EN'];
    aNNOUNCEDDATE = json['ANNOUNCED_DATE'];
    eVENTDESCKR = json['EVENT_DESC_KR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EFFECTIVE_DATE'] = eFFECTIVEDATE;
    data['EVENT_DESC_JP'] = eVENTDESCJP;
    data['EVENT_DATE'] = eVENTDATE;
    data['LAST_REG_DATE'] = lASTREGDATE;
    data['EVENT_DESC'] = eVENTDESC;
    data['EX_DATE'] = eXDATE;
    data['EVENT_DESC_CN'] = eVENTDESCCN;
    data['SECURITY_CODE'] = sECURITYCODE;
    data['EVENT_DESC_EN'] = eVENTDESCEN;
    data['ANNOUNCED_DATE'] = aNNOUNCEDDATE;
    data['EVENT_DESC_KR'] = eVENTDESCKR;
    return data;
  }

  static List<SecEvent> fromJsonModel(List<dynamic> listDynamic) {
    List<SecEvent> listData =
    listDynamic.map((e) => SecEvent.fromJson(e)).toList();
    return listData;
  }
}