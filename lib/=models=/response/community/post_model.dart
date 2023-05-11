import 'package:dtnd/data/i_community_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:get/get.dart';

import 'post_comment_model.dart';

class PostModel {
  late final String id;
  late final String user;
  late String content;
  late String contentShort;
  late String imageUrl;
  late DateTime createTime;
  late int checkState;
  late int viewCount;
  final RxList<PostCommentModel> comments = RxList.empty();
  late int commentCount;

  // Call when user create new post
  PostModel.createPost(this.user);

  // Call when fetch posts from server
  PostModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    user = json["user"];
    content = json["status"];
    contentShort = json["statusShort"];
    imageUrl = json["imageUrl"];
    createTime = TimeUtilities.isoFormat.parse(json["timeCreate"]);
    checkState = json["checkState"];
    viewCount = json["viewCount"];
    commentCount = json["commentCount"];
  }

  // Call when user create new post
  void copyWith({
    String? content,
    String? imageUrl,
    int? checkState,
    int? viewCount,
    int? commentCount,
  }) {
    if (content != null) {
      this.content = content;
    }
    if (imageUrl != null) {
      this.imageUrl = imageUrl;
    }
    if (checkState != null) {
      this.checkState = checkState;
    }
    if (viewCount != null) {
      this.viewCount = viewCount;
    }
    if (commentCount != null) {
      this.commentCount = commentCount;
    }
  }

  // Attach id for post after post post successfully
  void onPostSuccessfully(String id) {
    this.id = id;
    viewCount = 0;
    commentCount = 0;
  }

  // Check duplicate comments when fetch more comments
  List<PostCommentModel> _removeDuplicateComments(
      List<PostCommentModel> comments) {
    if (this.comments.isEmpty) {
      return comments;
    }
    final List<bool> removeFlags = List.filled(comments.length, false);

    for (var i = 0; i < comments.length; i++) {
      // Check duplicate
      if (comments.elementAt(i).id ==
          this.comments.elementAt(this.comments.length - 1 - i).id) {
        // Raise flag when comment is duplicated
        removeFlags[i] = true;
      } else {
        break;
      }
    }
    comments.removeWhere(
        (element) => removeFlags.elementAt(comments.indexOf(element)));
    return comments;
  }

  // Fetch more comments
  Future<List<PostCommentModel>> loadComments(INetworkService networkService,
      IUserService userService, ICommunityService communityService,
      {int? page, int? records}) async {
    try {
      final newComments = await communityService.loadComments(
          networkService, userService, this,
          page: page ?? 1, records: records ?? 10);
      if (comments.isNotEmpty) {
        comments.clear();
        comments.addAll(_removeDuplicateComments(newComments));
        return comments;
      } else {
        comments.addAll(_removeDuplicateComments(newComments));
        return comments;
      }
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  // Clear comments
  void clearComments() {
    comments.clear();
  }
}
