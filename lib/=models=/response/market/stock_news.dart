class StockNews {
  String? imageUrl;
  String? stockCode;
  int? channelID;
  String? head;
  late final int articleID;
  String? title;
  String? publishTime;
  String? content;
  String? source;
  String? author;
  String? uRL;
  int? totalRow;

  DateTime? get dateTime {
    return DateTime.tryParse(publishTime!);
  }

  StockNews(
      {this.imageUrl,
      this.stockCode,
      this.channelID,
      this.head,
      required this.articleID,
      this.title,
      this.publishTime,
      this.content,
      this.source,
      this.author,
      this.uRL,
      this.totalRow});

  StockNews.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    stockCode = json['StockCode'];
    channelID = json['ChannelID'];
    head = json['Head'];
    articleID = json['ArticleID'];
    title = json['Title'];
    publishTime = json['PublishTime'];
    content = json['Content'];
    source = json['Source'];
    author = json['Author'];
    uRL = json['URL'];
    totalRow = json['TotalRow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['StockCode'] = stockCode;
    data['ChannelID'] = channelID;
    data['Head'] = head;
    data['ArticleID'] = articleID;
    data['Title'] = title;
    data['PublishTime'] = publishTime;
    data['Content'] = content;
    data['Source'] = source;
    data['Author'] = author;
    data['URL'] = uRL;
    data['TotalRow'] = totalRow;
    return data;
  }
}
