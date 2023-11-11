import 'dart:ui';

class StockMatched {
  late final int pKID;
  late final String sTOCKCODE;
  late final num lASTPRICE;
  late final num lASTVOL;
  late final num uPDATEDTIME;
  late final num tOTALVOL;
  late final Color cOLOR;

  StockMatched(this.pKID, this.sTOCKCODE, this.lASTPRICE, this.lASTVOL,
      this.uPDATEDTIME, this.tOTALVOL, this.cOLOR);

  StockMatched.fromJson(Map<String, dynamic> json) {
    pKID = json['PK_ID'];
    sTOCKCODE = json['STOCK_CODE'];
    lASTPRICE = json['LAST_PRICE'];
    lASTVOL = json['LAST_VOL'];
    uPDATEDTIME = json['UPDATED_TIME'];
    tOTALVOL = json['TOTAL_VOL'];
    cOLOR = json['COLOR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PK_ID'] = pKID;
    data['STOCK_CODE'] = sTOCKCODE;
    data['LAST_PRICE'] = lASTPRICE;
    data['LAST_VOL'] = lASTVOL;
    data['UPDATED_TIME'] = uPDATEDTIME;
    data['TOTAL_VOL'] = tOTALVOL;
    data['COLOR'] = cOLOR;
    return data;
  }
}
