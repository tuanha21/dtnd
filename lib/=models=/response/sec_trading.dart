import 'package:intl/intl.dart';

class SecTrading {
  num? pPRICE1D;
  num? tOTPTVOLUME;
  num? tOTPTVALUE;
  num? cLOSEPRICE;
  num? pINETBUYVOL;
  num? rEFPRICE;
  num? tOTVOLUME;
  String? sECURITYCODE;
  num? fLOORPRICE;
  num? cEILINGPRICE;
  num? fNETBUYVOLUME;
  String? tRADEDATE;
  num? tOTVALUE;

  DateTime? get dateTime {
    if (tRADEDATE == null) return null;
    return DateTime.tryParse(tRADEDATE!);
  }

  String get time {
    if (dateTime == null) return "";
    return DateFormat("dd/MM").format(dateTime!);
  }

  SecTrading(
      {this.pPRICE1D,
      this.tOTPTVOLUME,
      this.tOTPTVALUE,
      this.cLOSEPRICE,
      this.pINETBUYVOL,
      this.rEFPRICE,
      this.tOTVOLUME,
      this.sECURITYCODE,
      this.fLOORPRICE,
      this.cEILINGPRICE,
      this.fNETBUYVOLUME,
      this.tRADEDATE,
      this.tOTVALUE});

  SecTrading.fromJson(Map<String, dynamic> json) {
    pPRICE1D = json['P_PRICE_1D'];
    tOTPTVOLUME = json['TOT_PT_VOLUME'];
    tOTPTVALUE = json['TOT_PT_VALUE'];
    cLOSEPRICE = json['CLOSE_PRICE'];
    pINETBUYVOL = json['PI_NET_BUY_VOL'];
    rEFPRICE = json['REF_PRICE'];
    tOTVOLUME = json['TOT_VOLUME'];
    sECURITYCODE = json['SECURITY_CODE'];
    fLOORPRICE = json['FLOOR_PRICE'];
    cEILINGPRICE = json['CEILING_PRICE'];
    fNETBUYVOLUME = json['F_NET_BUY_VOLUME'];
    tRADEDATE = json['TRADE_DATE'];
    tOTVALUE = json['TOT_VALUE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['P_PRICE_1D'] = pPRICE1D;
    data['TOT_PT_VOLUME'] = tOTPTVOLUME;
    data['TOT_PT_VALUE'] = tOTPTVALUE;
    data['CLOSE_PRICE'] = cLOSEPRICE;
    data['PI_NET_BUY_VOL'] = pINETBUYVOL;
    data['REF_PRICE'] = rEFPRICE;
    data['TOT_VOLUME'] = tOTVOLUME;
    data['SECURITY_CODE'] = sECURITYCODE;
    data['FLOOR_PRICE'] = fLOORPRICE;
    data['CEILING_PRICE'] = cEILINGPRICE;
    data['F_NET_BUY_VOLUME'] = fNETBUYVOLUME;
    data['TRADE_DATE'] = tRADEDATE;
    data['TOT_VALUE'] = tOTVALUE;
    return data;
  }
}
