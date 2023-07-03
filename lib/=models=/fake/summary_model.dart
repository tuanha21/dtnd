class SummaryModel {
  num? noticeId;
  String? title;
  ContentFull? contentFull;
  num? date;
  DateTime? regDateTime;
  num? status;
  String? flashDealType;
  String? shareCode;

  SummaryModel(
      {this.noticeId,
      this.title,
      this.contentFull,
      this.date,
      this.regDateTime,
      this.status,
      this.flashDealType,
      this.shareCode});

  SummaryModel.fromJson(Map<String, dynamic> json) {
    noticeId = json['noticeId'];
    title = json['title'];
    contentFull = json['contentFull'] != null
        ? ContentFull.fromJson(json['contentFull'])
        : null;
    date = json['date'];
    regDateTime = DateTime.fromMillisecondsSinceEpoch(json['regDateTime']);
    status = json['status'];
    flashDealType = json['flashDealType'];
    shareCode = json['shareCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noticeId'] = noticeId;
    data['title'] = title;
    if (contentFull != null) {
      data['contentFull'] = contentFull!.toJson();
    }
    data['date'] = date;
    data['regDateTime'] = regDateTime;
    data['status'] = status;
    data['flashDealType'] = flashDealType;
    data['shareCode'] = shareCode;
    return data;
  }
}

class ContentFull {
  String? createAt;
  String? title;
  List<IndexSummaries>? indexSummaries;
  ForeignRoomSummary? foreignRoomSummary;
  List<DerivativesSummaries>? derivativesSummaries;

  ContentFull(
      {this.createAt,
      this.title,
      this.indexSummaries,
      this.foreignRoomSummary,
      this.derivativesSummaries});

  ContentFull.fromJson(Map<String, dynamic> json) {
    createAt = json['createAt'];
    title = json['title'];
    if (json['indexSummaries'] != null) {
      indexSummaries = <IndexSummaries>[];
      json['indexSummaries'].forEach((v) {
        indexSummaries!.add(IndexSummaries.fromJson(v));
      });
    }
    foreignRoomSummary = json['foreignRoomSummary'] != null
        ? ForeignRoomSummary.fromJson(json['foreignRoomSummary'])
        : null;
    if (json['derivativesSummaries'] != null) {
      derivativesSummaries = <DerivativesSummaries>[];
      json['derivativesSummaries'].forEach((v) {
        derivativesSummaries!.add(DerivativesSummaries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createAt'] = createAt;
    data['title'] = title;
    if (indexSummaries != null) {
      data['indexSummaries'] = indexSummaries!.map((v) => v.toJson()).toList();
    }
    if (foreignRoomSummary != null) {
      data['foreignRoomSummary'] = foreignRoomSummary!.toJson();
    }
    if (derivativesSummaries != null) {
      data['derivativesSummaries'] =
          derivativesSummaries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IndexSummaries {
  String? code;
  num? value;
  num? changedValue;
  num? changedPercentage;
  num? color;
  num? totalSharesTraded;
  num? totalValuesTraded;
  num? totalForeignBuyValue;
  num? totalForeignSellValue;
  num? totalForeignNetValue;
  num? advances;
  num? declines;
  num? noChange;
  String? indexDescription;
  String? morningDescription;
  String? closeDescription;
  String? summary;

  IndexSummaries(
      {this.code,
      this.value,
      this.changedValue,
      this.changedPercentage,
      this.color,
      this.totalSharesTraded,
      this.totalValuesTraded,
      this.totalForeignBuyValue,
      this.totalForeignSellValue,
      this.totalForeignNetValue,
      this.advances,
      this.declines,
      this.noChange,
      this.indexDescription,
      this.morningDescription,
      this.closeDescription,
      this.summary});

  IndexSummaries.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    value = json['value'];
    changedValue = json['changedValue'];
    changedPercentage = json['changedPercentage'];
    color = json['color'];
    totalSharesTraded = json['totalSharesTraded'];
    totalValuesTraded = json['totalValuesTraded'];
    totalForeignBuyValue = json['totalForeignBuyValue'];
    totalForeignSellValue = json['totalForeignSellValue'];
    totalForeignNetValue = json['totalForeignNetValue'];
    advances = json['advances'];
    declines = json['declines'];
    noChange = json['noChange'];
    indexDescription = json['indexDescription'];
    morningDescription = json['morningDescription'];
    closeDescription = json['closeDescription'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['value'] = value;
    data['changedValue'] = changedValue;
    data['changedPercentage'] = changedPercentage;
    data['color'] = color;
    data['totalSharesTraded'] = totalSharesTraded;
    data['totalValuesTraded'] = totalValuesTraded;
    data['totalForeignBuyValue'] = totalForeignBuyValue;
    data['totalForeignSellValue'] = totalForeignSellValue;
    data['totalForeignNetValue'] = totalForeignNetValue;
    data['advances'] = advances;
    data['declines'] = declines;
    data['noChange'] = noChange;
    data['indexDescription'] = indexDescription;
    data['morningDescription'] = morningDescription;
    data['closeDescription'] = closeDescription;
    data['summary'] = summary;
    return data;
  }
}

class ForeignRoomSummary {
  List<TopBuyNetValue>? topBuyNetValue;
  List<TopSeLLNetValue>? topSeLLNetValue;

  ForeignRoomSummary({this.topBuyNetValue, this.topSeLLNetValue});

  ForeignRoomSummary.fromJson(Map<String, dynamic> json) {
    if (json['topBuyNetValue'] != null) {
      topBuyNetValue = <TopBuyNetValue>[];
      json['topBuyNetValue'].forEach((v) {
        topBuyNetValue!.add(TopBuyNetValue.fromJson(v));
      });
    }
    if (json['topSeLLNetValue'] != null) {
      topSeLLNetValue = <TopSeLLNetValue>[];
      json['topSeLLNetValue'].forEach((v) {
        topSeLLNetValue!.add(TopSeLLNetValue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topBuyNetValue != null) {
      data['topBuyNetValue'] = topBuyNetValue!.map((v) => v.toJson()).toList();
    }
    if (topSeLLNetValue != null) {
      data['topSeLLNetValue'] =
          topSeLLNetValue!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopBuyNetValue {
  String? security;
  num? value;

  TopBuyNetValue({this.security, this.value});

  TopBuyNetValue.fromJson(Map<String, dynamic> json) {
    security = json['security'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['security'] = security;
    data['value'] = value;
    return data;
  }
}

class TopSeLLNetValue {
  String? security;
  num? value;

  TopSeLLNetValue({this.security, this.value});

  TopSeLLNetValue.fromJson(Map<String, dynamic> json) {
    security = json['security'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['security'] = security;
    data['value'] = value;
    return data;
  }
}

class DerivativesSummaries {
  String? code;
  num? value;
  num? changedValue;
  num? changedPercentage;
  num? color;
  num? totalSharesTraded;
  num? foreignAccumulatedNetValue;
  num? biasPrice;
  num? highestPrice;
  num? lowestPrice;

  DerivativesSummaries(
      {this.code,
      this.value,
      this.changedValue,
      this.changedPercentage,
      this.color,
      this.totalSharesTraded,
      this.foreignAccumulatedNetValue,
      this.biasPrice,
      this.highestPrice,
      this.lowestPrice});

  DerivativesSummaries.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    value = json['value'];
    changedValue = json['changedValue'];
    changedPercentage = json['changedPercentage'];
    color = json['color'];
    totalSharesTraded = json['totalSharesTraded'];
    foreignAccumulatedNetValue = json['foreignAccumulatedNetValue'];
    biasPrice = json['biasPrice'];
    highestPrice = json['highestPrice'];
    lowestPrice = json['lowestPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['value'] = value;
    data['changedValue'] = changedValue;
    data['changedPercentage'] = changedPercentage;
    data['color'] = color;
    data['totalSharesTraded'] = totalSharesTraded;
    data['foreignAccumulatedNetValue'] = foreignAccumulatedNetValue;
    data['biasPrice'] = biasPrice;
    data['highestPrice'] = highestPrice;
    data['lowestPrice'] = lowestPrice;
    return data;
  }
}
