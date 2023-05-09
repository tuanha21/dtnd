import 'package:dtnd/utilities/time_utils.dart';

class PostCommentModel {
  late final String id;
  late final String communityId;
  late final String user;
  late String comment;
  late DateTime createTime;
  late int checkState;

  PostCommentModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    communityId = json["communityId"];
    user = json["user"];
    comment = json["comment"];
    createTime = TimeUtilities.isoFormat.parse(json["timeCreate"]);
    checkState = json["checkState"];
  }
}
