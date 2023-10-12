class NewsModel {
  int? articleID;
  String? title;
  String? publishTime;
  String? headImg;
  late int viewCount;
  int? commentCount;

  NewsModel(
      {this.articleID,
      this.title,
      this.publishTime,
      this.headImg,
      this.viewCount = 0,
      this.commentCount});

  NewsModel.fromJson(Map<String, dynamic> json) {
    articleID = json['articleID'];
    title = json['title'];
    publishTime = json['publishTime'];
    headImg = json['headImg'];
    viewCount = json['viewCount'] ?? 0;
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['articleID'] = articleID;
    data['title'] = title;
    data['publishTime'] = publishTime;
    data['headImg'] = headImg;
    data['viewCount'] = viewCount;
    data['commentCount'] = commentCount;
    return data;
  }
}
