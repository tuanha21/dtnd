import 'dart:ffi';

import 'package:dtnd/=models=/response/community/post_comment_model.dart';
import 'package:dtnd/=models=/response/community/post_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';

import 'implementations/community_service.dart';

abstract class ICommunityService {
  factory ICommunityService() => CommunityService();

  /// Deo comment nua hoc Tieng Anh di tu hieu
  Future<List<PostModel>> loadPosts(
      INetworkService networkService, IUserService userService,
      {String? byAccount, int? page, int? records});

  Future<List<PostCommentModel>> loadComments(
      INetworkService networkService, IUserService userService, PostModel post,
      {int? page, int? records});

  Future<PostModel?> loadPostDetail(
      INetworkService networkService, IUserService userService, PostModel post);

  Future<bool> postPosts(INetworkService networkService,
      IUserService userService, String status);
}
