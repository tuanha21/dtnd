class BriefModel {
  num? noticeId;
  String? title;
  ContentFull? contentFull;
  num? date;
  DateTime? regDateTime;
  num? status;
  String? flashDealType;
  String? shareCode;

  BriefModel(
      {this.noticeId,
      this.title,
      this.contentFull,
      this.date,
      this.regDateTime,
      this.status,
      this.flashDealType,
      this.shareCode});

  BriefModel.fromJson(Map<String, dynamic> json) {
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
  num? id;
  String? title;
  String? trend;
  String? buyStrategy;
  String? sellStrategy;
  num? recommendId;
  num? recommendations;
  String? linkFile;
  List<WorldMarket>? worldMarket;
  String? createAt;
  String? createBy;
  String? updateAt;
  String? updateBy;
  num? status;
  RecommendForMorningNews? recommendForMorningNews;

  ContentFull(
      {this.id,
      this.title,
      this.trend,
      this.buyStrategy,
      this.sellStrategy,
      this.recommendId,
      this.recommendations,
      this.linkFile,
      this.worldMarket,
      this.createAt,
      this.createBy,
      this.updateAt,
      this.updateBy,
      this.status,
      this.recommendForMorningNews});

  ContentFull.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    trend = json['trend'];
    buyStrategy = json['buyStrategy'];
    sellStrategy = json['sellStrategy'];
    recommendId = json['recommendId'];
    recommendations = json['recommendations'];
    linkFile = json['linkFile'];
    if (json['worldMarket'] != null) {
      worldMarket = <WorldMarket>[];
      json['worldMarket'].forEach((v) {
        worldMarket!.add(WorldMarket.fromJson(v));
      });
    }
    createAt = json['createAt'];
    createBy = json['createBy'];
    updateAt = json['updateAt'];
    updateBy = json['updateBy'];
    status = json['status'];
    recommendForMorningNews = json['recommendForMorningNews'] != null
        ? RecommendForMorningNews.fromJson(json['recommendForMorningNews'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['trend'] = trend;
    data['buyStrategy'] = buyStrategy;
    data['sellStrategy'] = sellStrategy;
    data['recommendId'] = recommendId;
    data['recommendations'] = recommendations;
    data['linkFile'] = linkFile;
    if (worldMarket != null) {
      data['worldMarket'] = worldMarket!.map((v) => v.toJson()).toList();
    }
    data['createAt'] = createAt;
    data['createBy'] = createBy;
    data['updateAt'] = updateAt;
    data['updateBy'] = updateBy;
    data['status'] = status;
    if (recommendForMorningNews != null) {
      data['recommendForMorningNews'] = recommendForMorningNews!.toJson();
    }
    return data;
  }
}

class WorldMarket {
  String? marketCode;
  String? marketName;
  num? close;
  num? change;
  num? changePercent;

  WorldMarket(
      {this.marketCode,
      this.marketName,
      this.close,
      this.change,
      this.changePercent});

  WorldMarket.fromJson(Map<String, dynamic> json) {
    marketCode = json['marketCode'];
    marketName = json['marketName'];
    close = json['close'];
    change = json['change'];
    changePercent = json['changePercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['marketCode'] = marketCode;
    data['marketName'] = marketName;
    data['close'] = close;
    data['change'] = change;
    data['changePercent'] = changePercent;
    return data;
  }
}

class RecommendForMorningNews {
  String? securitiesCode;
  num? fromPrice;
  num? toPrice;
  num? targetPrice;
  num? stopLossPrice;
  num? upsize;
  String? analyticalSummary;
  num? recommendStatus;

  RecommendForMorningNews(
      {this.securitiesCode,
      this.fromPrice,
      this.toPrice,
      this.targetPrice,
      this.stopLossPrice,
      this.upsize,
      this.analyticalSummary,
      this.recommendStatus});

  RecommendForMorningNews.fromJson(Map<String, dynamic> json) {
    securitiesCode = json['securitiesCode'];
    fromPrice = json['fromPrice'];
    toPrice = json['toPrice'];
    targetPrice = json['targetPrice'];
    stopLossPrice = json['stopLossPrice'];
    upsize = json['upsize'];
    analyticalSummary = json['analyticalSummary'];
    recommendStatus = json['recommendStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['securitiesCode'] = securitiesCode;
    data['fromPrice'] = fromPrice;
    data['toPrice'] = toPrice;
    data['targetPrice'] = targetPrice;
    data['stopLossPrice'] = stopLossPrice;
    data['upsize'] = upsize;
    data['analyticalSummary'] = analyticalSummary;
    data['recommendStatus'] = recommendStatus;
    return data;
  }
}
