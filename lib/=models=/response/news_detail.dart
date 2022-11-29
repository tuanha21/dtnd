class NewsDetail {
  int? articleID;
  String? title;
  String? head;
  String? headImageUrl;
  String? publishTime;
  String? author;
  String? content;
  String? thumbImageUrl;
  String? uRL;
  String? source;
  int? wordCount;
  String? tag;
  List<StockNewsDetail>? stock;

  NewsDetail(
      {this.articleID,
      this.title,
      this.head,
      this.headImageUrl,
      this.publishTime,
      this.author,
      this.content,
      this.thumbImageUrl,
      this.uRL,
      this.source,
      this.wordCount,
      this.tag,
      this.stock});

  NewsDetail.fromJson(Map<String, dynamic> json) {
    articleID = json['ArticleID'];
    title = json['Title'];
    head = json['Head'];
    headImageUrl = json['HeadImageUrl'];
    publishTime = json['PublishTime'];
    author = json['Author'];
    content = json['Content'];
    thumbImageUrl = json['ThumbImageUrl'];
    uRL = json['URL'];
    source = json['Source'];
    wordCount = json['WordCount'];
    tag = json['Tag'];
    if (json['Stock'] != null) {
      stock = <StockNewsDetail>[];
      json['Stock'].forEach((v) {
        stock!.add(StockNewsDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ArticleID'] = articleID;
    data['Title'] = title;
    data['Head'] = head;
    data['HeadImageUrl'] = headImageUrl;
    data['PublishTime'] = publishTime;
    data['Author'] = author;
    data['Content'] = content;
    data['ThumbImageUrl'] = thumbImageUrl;
    data['URL'] = uRL;
    data['Source'] = source;
    data['WordCount'] = wordCount;
    data['Tag'] = tag;
    if (stock != null) {
      data['Stock'] = stock!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockNewsDetail {
  String? stockCode;
  int? closePrice;
  int? change;
  double? perChange;
  int? totalVol;
  String? financeURL;
  int? colorId;
  int? catID;

  StockNewsDetail(
      {this.stockCode,
      this.closePrice,
      this.change,
      this.perChange,
      this.totalVol,
      this.financeURL,
      this.colorId,
      this.catID});

  StockNewsDetail.fromJson(Map<String, dynamic> json) {
    stockCode = json['StockCode'];
    closePrice = json['ClosePrice'];
    change = json['Change'];
    perChange = json['PerChange'];
    totalVol = json['TotalVol'];
    financeURL = json['FinanceURL'];
    colorId = json['ColorId'];
    catID = json['CatID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StockCode'] = stockCode;
    data['ClosePrice'] = closePrice;
    data['Change'] = change;
    data['PerChange'] = perChange;
    data['TotalVol'] = totalVol;
    data['FinanceURL'] = financeURL;
    data['ColorId'] = colorId;
    data['CatID'] = catID;
    return data;
  }
}
