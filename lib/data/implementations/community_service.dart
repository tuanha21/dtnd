import 'dart:convert';

import 'package:dtnd/=models=/response/community/post_comment_model.dart';
import 'package:dtnd/=models=/response/community/post_model.dart';
import 'package:dtnd/data/i_community_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';

class CommunityService implements ICommunityService {
  static final CommunityService _instance = CommunityService._intern();

  CommunityService._intern();

  factory CommunityService() => _instance;

  @override
  Future<List<PostModel>> loadPosts(
      INetworkService networkService, IUserService userService,
      {String? byAccount, int? page, int? records}) async {
    if (!userService.isLogin) {
      return Future.value([]);
    }
    final Map<String, dynamic> body = {
      "user": userService.token.value!.user,
      "session": userService.token.value!.sid,
      "page": page ?? 1,
      "records": records ?? 10,
    };
    if (byAccount != null) {
      body["account"] = byAccount;
    }

    final response = await networkService.post(
        networkService.url_core1("community/pickStatus"),
        body: jsonEncode(body));

    final result = networkService.decode(response.bodyBytes);
    if (result is! Map || result["rc"] != 1) {
      throw result;
    }
    final List<PostModel> posts = [];
    for (var i = 0; i < result["data"].length; i++) {
      posts.add(PostModel.fromJson(result["data"].elementAt(i)));
    }
    return posts;
  }

  @override
  Future<List<PostCommentModel>> loadComments(
      INetworkService networkService, IUserService userService, PostModel post,
      {int? page, int? records}) async {
    if (!userService.isLogin) {
      return Future.value([]);
    }
    final Map<String, dynamic> body = {
      "user": userService.token.value!.user,
      "session": userService.token.value!.sid,
      "communityId": post.id,
      "page": page ?? 1,
      "records": records ?? 10,
    };

    final response = await networkService.post(
        networkService.url_core1("community/pickComments"),
        body: jsonEncode(body));

    final result = networkService.decode(response.bodyBytes);
    if (result is! Map || result["rc"] != 1) {
      throw result;
    }
    final List<PostCommentModel> comments = [];
    for (var i = 0; i < result["data"].length; i++) {
      comments.add(PostCommentModel.fromJson(result["data"].elementAt(i)));
    }
    return comments;
  }

  @override
  Future<PostModel?> loadPostDetail(INetworkService networkService,
      IUserService userService, PostModel post) async {
    if (!userService.isLogin) {
      return Future.value();
    }
    final Map<String, dynamic> body = {
      "user": userService.token.value!.user,
      "session": userService.token.value!.sid,
      "communityId": post.id,
    };

    final response = await networkService.post(
        networkService.url_core1("community/detailStatus"),
        body: jsonEncode(body));

    final result = networkService.decode(response.bodyBytes);
    if (result is! Map || result["rc"] != 1) {
      throw result;
    }
    final PostModel postReturn = PostModel.fromJson(result["data"]);
    return postReturn;
  }

  @override
  Future<bool> postPosts(INetworkService networkService,
      IUserService userService, String status) async {
    if (!userService.isLogin) {
      return false;
    }
    final Map<String, dynamic> body = {
      "user": userService.token.value!.user,
      "session": userService.token.value!.sid,
      "status": status,
      "imageUrl": ""
    };
    final response = await networkService.post(
        networkService.url_core1("community/postStatus"),
        body: jsonEncode(body));

    final result = networkService.decode(response.bodyBytes);

    if (result["rc"] == 1) {
      return true;
    } else {
      return false;
    }

    //
    // if (result is! Map || result["rc"] != 1) {
    //   throw result;
    // }
    // final PostModel postReturn = PostModel.fromJson(result["data"]);
    // return postReturn;
  }
}
