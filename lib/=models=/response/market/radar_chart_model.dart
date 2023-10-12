class RadarChartModel {
  num? mkDvdGrowth1y;
  num? indPriceBvpst;
  num? indRoe;
  num? secEpsGrowth1y;
  num? indRevGrowth3y;
  num? indPe;
  num? indAssetsTurn;
  num? indDpsGrowth3y;
  num? secLiabEquity;
  String? securityCode;
  num? mkDvdPerSec;
  num? indRoa;
  num? indEpsGrowth3y;
  num? secRevGrowth1y;
  num? indRevGrowthQy;
  num? mkRevGrowth3y;
  num? secEpsGrowthQy;
  num? mkPs;
  num? indLiabEquity;
  num? mkEpsGrowth3y;
  num? mkDpsGrowth3y;
  num? mkBvpsTangible;
  num? indOperatingMargin;
  num? secBvpsTangible;
  num? mkRoa;
  num? mkLiabEquity;
  String? level4Code;
  num? mkRoe;
  num? indBvpsTangible;
  num? mkMc;
  num? secRevGrowthQy;
  num? indEpsGrowthQy;
  num? secPriceBvpst;
  num? mkEvPerEbitda;
  num? secOperatingMargin;
  num? secDvdPerSec;
  num? mkOperatingMargin;
  num? mkRevGrowthQy;
  num? indRevGrowth1y;
  num? secEpsGrowth3y;
  num? mkEpsGrowthQy;
  num? indDvdPerSec;
  num? mkPriceBvpst;
  num? secPe;
  num? secDpsGrowth3y;
  num? mkAssetsTurn;
  num? mkFcfPerSec;
  num? mkPe;
  num? secRoa;
  num? secAssetsTurn;
  num? secRevGrowth3y;
  num? secRoe;
  String? level2Code;
  num? indEpsGrowth1y;
  num? secDvdGrowth1y;
  num? secPs;
  num? mkRevGrowth1y;
  num? indDvdGrowth1y;
  num? mkEpsGrowth1y;
  num? secRoce;
  num? secMc;
  num? indMc;
  num? indLeverage;
  num? secLeverage;
  num? mkLeverage;
  num? mkRoce;
  num? indPs;

  RadarChartModel(
      {this.mkDvdGrowth1y,
      this.indPriceBvpst,
      this.indRoe,
      this.secEpsGrowth1y,
      this.indRevGrowth3y,
      this.indPe,
      this.indAssetsTurn,
      this.indDpsGrowth3y,
      this.secLiabEquity,
      this.securityCode,
      this.mkDvdPerSec,
      this.indRoa,
      this.indEpsGrowth3y,
      this.secRevGrowth1y,
      this.indRevGrowthQy,
      this.mkRevGrowth3y,
      this.secEpsGrowthQy,
      this.mkPs,
      this.indLiabEquity,
      this.mkEpsGrowth3y,
      this.mkDpsGrowth3y,
      this.mkBvpsTangible,
      this.indOperatingMargin,
      this.secBvpsTangible,
      this.mkRoa,
      this.mkLiabEquity,
      this.level4Code,
      this.mkRoe,
      this.indBvpsTangible,
      this.mkMc,
      this.secRevGrowthQy,
      this.indEpsGrowthQy,
      this.secPriceBvpst,
      this.mkEvPerEbitda,
      this.secOperatingMargin,
      this.secDvdPerSec,
      this.mkOperatingMargin,
      this.mkRevGrowthQy,
      this.indRevGrowth1y,
      this.secEpsGrowth3y,
      this.mkEpsGrowthQy,
      this.indDvdPerSec,
      this.mkPriceBvpst,
      this.secPe,
      this.secDpsGrowth3y,
      this.mkAssetsTurn,
      this.mkFcfPerSec,
      this.mkPe,
      this.secRoa,
      this.secAssetsTurn,
      this.secRevGrowth3y,
      this.secRoe,
      this.level2Code,
      this.indEpsGrowth1y,
      this.secDvdGrowth1y,
      this.secPs,
      this.mkRevGrowth1y,
      this.indDvdGrowth1y,
      this.mkEpsGrowth1y,
      this.secRoce,
      this.secMc,
      this.indMc,
      this.indLeverage,
      this.secLeverage,
      this.mkLeverage,
      this.mkRoce,
      this.indPs});

  RadarChartModel.fromJson(Map<String, dynamic> json) {
    mkDvdGrowth1y = json['MK_DVD_GROWTH_1Y'];
    indPriceBvpst = json['IND_PRICE_BVPST'];
    indRoe = json['IND_ROE'];
    secEpsGrowth1y = json['SEC_EPS_GROWTH_1Y'];
    indRevGrowth3y = json['IND_REV_GROWTH_3Y'];
    indPe = json['IND_PE'];
    indAssetsTurn = json['IND_ASSETS_TURN'];
    indDpsGrowth3y = json['IND_DPS_GROWTH_3Y'];
    secLiabEquity = json['SEC_LIAB_EQUITY'];
    securityCode = json['SECURITY_CODE'];
    mkDvdPerSec = json['MK_DVD_PER_SEC'];
    indRoa = json['IND_ROA'];
    indEpsGrowth3y = json['IND_EPS_GROWTH_3Y'];
    secRevGrowth1y = json['SEC_REV_GROWTH_1Y'];
    indRevGrowthQy = json['IND_REV_GROWTH_QY'];
    mkRevGrowth3y = json['MK_REV_GROWTH_3Y'];
    secEpsGrowthQy = json['SEC_EPS_GROWTH_QY'];
    mkPs = json['MK_PS'];
    indLiabEquity = json['IND_LIAB_EQUITY'];
    mkEpsGrowth3y = json['MK_EPS_GROWTH_3Y'];
    mkDpsGrowth3y = json['MK_DPS_GROWTH_3Y'];
    mkBvpsTangible = json['MK_BVPS_TANGIBLE'];
    indOperatingMargin = json['IND_OPERATING_MARGIN'];
    secBvpsTangible = json['SEC_BVPS_TANGIBLE'];
    mkRoa = json['MK_ROA'];
    mkLiabEquity = json["MK_LIAB_EQUITY"];
    level4Code = json["LEVEL4_CODE"];
    mkRoe = json["MK_ROE"];
    indBvpsTangible = json["IND_BVPS_TANGIBLE"];
    mkMc = json["MK_MC"];
    secRevGrowthQy = json["SEC_REV_GROWTH_QY"];
    indEpsGrowthQy = json["IND_EPS_GROWTH_QY"];
    secPriceBvpst = json["SEC_PRICE_BVPST"];
    mkEvPerEbitda = json["MK_EV_PER_EBITDA"];
    secOperatingMargin = json["SEC_OPERATING_MARGIN"];
    secDvdPerSec = json["SEC_DVD_PER_SEC"];
    mkOperatingMargin = json["MK_OPERATING_MARGIN"];
    mkRevGrowthQy = json["MK_REV_GROWTH_QY"];
    indRevGrowth1y = json["IND_REV_GROWTH_1Y"];
    secEpsGrowth3y = json["SEC_EPS_GROWTH_3Y"];
    mkEpsGrowthQy = json["MK_EPS_GROWTH_QY"];
    indDvdPerSec = json["IND_DVD_PER_SEC"];
    mkPriceBvpst = json["MK_PRICE_BVPST"];
    secPe = json["SEC_PE"];
    secDpsGrowth3y = json["SEC_DPS_GROWTH_3Y"];
    mkAssetsTurn = json["MK_ASSETS_TURN"];
    mkFcfPerSec = json["MK_FCF_PER_SEC"];
    mkPe = json["MK_PE"];
    secRoa = json["SEC_ROA"];
    secAssetsTurn = json["SEC_ASSETS_TURN"];
    secRevGrowth3y = json["SEC_REV_GROWTH_3Y"];
    secRoe = json["SEC_ROE"];
    level2Code = json["LEVEL2_CODE"];
    indEpsGrowth1y = json["IND_EPS_GROWTH_1Y"];
    secDvdGrowth1y = json["SEC_DVD_GROWTH_1Y"];
    secPs = json["SEC_PS"];
    mkRevGrowth1y = json["MK_REV_GROWTH_1Y"];
    indDvdGrowth1y = json["IND_DVD_GROWTH_1Y"];
    mkEpsGrowth1y = json["MK_EPS_GROWTH_1Y"];
    secRoce = json["SEC_ROCE"];
    secMc = json["SEC_MC"];
    indMc = json["IND_MC"];
    indLeverage = json["MK_LEVERAGE"];
    secLeverage = json["MK_LEVERAGE"];
    mkLeverage = json["MK_LEVERAGE"];
    mkRoce = json["MK_ROCE"];
    indPs = json["IND_PS"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['MK_DVD_GROWTH_1Y'] = mkDvdGrowth1y;
    data['IND_PRICE_BVPST'] = indPriceBvpst;
    data['IND_ROE'] = indRoe;
    data['SEC_EPS_GROWTH_1Y'] = secEpsGrowth1y;
    data['IND_REV_GROWTH_3Y'] = indRevGrowth3y;
    data['IND_PE'] = indPe;
    data['IND_ASSETS_TURN'] = indAssetsTurn;
    data['IND_DPS_GROWTH_3Y'] = indDpsGrowth3y;
    data['SEC_LIAB_EQUITY'] = secLiabEquity;
    data['SECURITY_CODE'] = securityCode;
    data['MK_DVD_PER_SEC'] = mkDvdPerSec;
    data['IND_ROA'] = indRoa;
    data['IND_EPS_GROWTH_3Y'] = indEpsGrowth3y;
    data['SEC_REV_GROWTH_1Y'] = secRevGrowth1y;
    data['IND_REV_GROWTH_QY'] = indRevGrowthQy;
    data['MK_REV_GROWTH_3Y'] = mkRevGrowth3y;
    data['SEC_EPS_GROWTH_QY'] = secEpsGrowthQy;
    data["MK_PS"] = mkPs;
    data["IND_LIAB_EQUITY"] = indLiabEquity;
    data["MK_EPS_GROWTH_3Y"] = mkEpsGrowth3y;
    data["MK_DPS_GROWTH_3Y"] = mkDpsGrowth3y;
    data["MK_BVPS_TANGIBLE"] = mkBvpsTangible;
    data["IND_OPERATING_MARGIN"] = indOperatingMargin;
    data["SEC_BVPS_TANGIBLE"] = secBvpsTangible;
    data["MK_ROA"] = mkRoa;
    data["MK_LIAB_EQUITY"] = mkLiabEquity;
    data["LEVEL4_CODE"] = level4Code;
    data["MK_ROE"] = mkRoe;
    data["IND_BVPS_TANGIBLE"] = indBvpsTangible;
    data["MK_MC"] = mkMc;
    data["SEC_REV_GROWTH_QY"] = secRevGrowthQy;
    data["IND_EPS_GROWTH_QY"] = indEpsGrowthQy;
    data["SEC_PRICE_BVPST"] = secPriceBvpst;
    data["MK_EV_PER_EBITDA"] = mkEvPerEbitda;
    data["SEC_OPERATING_MARGIN"] = secOperatingMargin;
    data["SEC_DVD_PER_SEC"] = secDvdPerSec;
    data["MK_OPERATING_MARGIN"] = mkOperatingMargin;
    data["MK_REV_GROWTH_QY"] = mkRevGrowthQy;
    data["IND_REV_GROWTH_1Y"] = indRevGrowth1y;
    data["SEC_EPS_GROWTH_3Y"] = secEpsGrowth3y;
    data["MK_EPS_GROWTH_QY"] = mkEpsGrowthQy;
    data["IND_DVD_PER_SEC"] = indDvdPerSec;
    data["MK_PRICE_BVPST"] = mkPriceBvpst;
    data["SEC_PE"] = secPe;
    data["SEC_DPS_GROWTH_3Y"] = secDpsGrowth3y;
    data["MK_ASSETS_TURN"] = mkAssetsTurn;
    data["MK_FCF_PER_SEC"] = mkFcfPerSec;
    data["MK_PE"] = mkPe;
    data["SEC_ROA"] = secRoa;
    data["SEC_ASSETS_TURN"] = secAssetsTurn;
    data["SEC_REV_GROWTH_3Y"] = secRevGrowth3y;
    data["SEC_ROE"] = secRoe;
    data["LEVEL2_CODE"] = level2Code;
    data["IND_EPS_GROWTH_1Y"] = indEpsGrowth1y;
    data["SEC_DVD_GROWTH_1Y"] = secDvdGrowth1y;
    data["SEC_PS"] = secPs;
    data["MK_REV_GROWTH_1Y"] = mkRevGrowth1y;
    data["IND_DVD_GROWTH_1Y"] = indDvdGrowth1y;
    data["MK_EPS_GROWTH_1Y"] = mkEpsGrowth1y;
    data["SEC_ROCE"] = secRoce;
    data["SEC_MC"] = secMc;
    data["IND_MC"] = indMc;
    data["MK_LEVERAGE"] = indLeverage;
    data["MK_LEVERAGE"] = secLeverage;
    data["MK_LEVERAGE"] = mkLeverage;
    data["MK_ROCE"] = mkRoce;
    data["IND_PS"] = indPs;

    return data;
  }

  @override
  String toString() {
    return 'RadarChartModel{mkDvdGrowth1y: $mkDvdGrowth1y, indPriceBvpst: $indPriceBvpst, indRoe: $indRoe, secEpsGrowth1y: $secEpsGrowth1y, indRevGrowth3y: $indRevGrowth3y, indPe: $indPe, indAssetsTurn: $indAssetsTurn, indDpsGrowth3y: $indDpsGrowth3y, secLiabEquity: $secLiabEquity, securityCode: $securityCode, mkDvdPerSec: $mkDvdPerSec, indRoa: $indRoa, indEpsGrowth3y: $indEpsGrowth3y, secRevGrowth1y: $secRevGrowth1y, indRevGrowthQy: $indRevGrowthQy, mkRevGrowth3y: $mkRevGrowth3y, secEpsGrowthQy: $secEpsGrowthQy, mkPs: $mkPs, indLiabEquity: $indLiabEquity, mkEpsGrowth3y: $mkEpsGrowth3y, mkDpsGrowth3y: $mkDpsGrowth3y, mkBvpsTangible: $mkBvpsTangible, indOperatingMargin: $indOperatingMargin, secBvpsTangible: $secBvpsTangible, mkRoa: $mkRoa, mkLiabEquity: $mkLiabEquity, level4Code: $level4Code, mkRoe: $mkRoe, indBvpsTangible: $indBvpsTangible, mkMc: $mkMc, secRevGrowthQy: $secRevGrowthQy, indEpsGrowthQy: $indEpsGrowthQy, secPriceBvpst: $secPriceBvpst, mkEvPerEbitda: $mkEvPerEbitda, secOperatingMargin: $secOperatingMargin, secDvdPerSec: $secDvdPerSec, mkOperatingMargin: $mkOperatingMargin, mkRevGrowthQy: $mkRevGrowthQy, indRevGrowth1y: $indRevGrowth1y, secEpsGrowth3y: $secEpsGrowth3y, mkEpsGrowthQy: $mkEpsGrowthQy, indDvdPerSec: $indDvdPerSec, mkPriceBvpst: $mkPriceBvpst, secPe: $secPe, secDpsGrowth3y: $secDpsGrowth3y, mkAssetsTurn: $mkAssetsTurn, mkFcfPerSec: $mkFcfPerSec, mkPe: $mkPe, secRoa: $secRoa, secAssetsTurn: $secAssetsTurn, secRevGrowth3y: $secRevGrowth3y, secRoe: $secRoe, level2Code: $level2Code, indEpsGrowth1y: $indEpsGrowth1y, secDvdGrowth1y: $secDvdGrowth1y, secPs: $secPs, mkRevGrowth1y: $mkRevGrowth1y, indDvdGrowth1y: $indDvdGrowth1y, mkEpsGrowth1y: $mkEpsGrowth1y, secRoce: $secRoce, secMc: $secMc, indMc: $indMc, indLeverage: $indLeverage, secLeverage: $secLeverage, mkLeverage: $mkLeverage, mkRoce: $mkRoce, indPs: $indPs}';
  }
}
