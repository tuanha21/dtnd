import 'package:intl/intl.dart';

final DateFormat _format = DateFormat("yyyy-MM-ddTHH:mm:ssZ");

class PostModel {
  late final String id;
  late final String user;
  late String content;
  late String contentShort;
  late String imageUrl;
  late DateTime createTime;
  late int checkState;
  late int viewCount;
  late int commentCount;

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    user = json["user"];
    id = json["status"];
    id = json["statusShort"];
    imageUrl = json["imageUrl"];
    createTime = _format.parse(json["timeCreate"]);
    checkState = json["checkState"];
    viewCount = json["viewCount"];
    commentCount = json["commentCount"];
  }

  PostModel.afterPost(String id) {
    id = id;
  }
}
