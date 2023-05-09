import 'package:dtnd/=models=/response/community/post_model.dart';
import 'package:dtnd/data/i_community_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:get/get.dart';

class CommunityController {
  static final CommunityController _instance = CommunityController._intern();

  final INetworkService networkService = NetworkService();

  final IUserService userService = UserService();

  final ICommunityService communityService = ICommunityService();

  CommunityController._intern();

  factory CommunityController() => _instance;

  Future<void> init() async {
    await getPosts();
  }

  Future<void> refresh() async {
    posts.clear();
    await getPosts();
  }

  Future<void> getPosts() async {
    if (loadingPosts.value) {
      return;
    }
    try {
      loadingPosts.value = true;

      final posts =
          await communityService.loadPosts(networkService, userService);
      this.posts.value = posts;
      loadingPosts.value = false;
    } catch (e) {
      logger.e(e);
      loadingPosts.value = false;
    }
  }

  Future<PostModel?> getPostDetail(PostModel post) async {
    try {
      final postDetail = await communityService.loadPostDetail(
          networkService, userService, post);
      return postDetail;
    } catch (e) {
      logger.v(e);
      rethrow;
    }
  }

  Future<bool> postPosts(String status) async {
    try {
      final postDetail = await communityService.postPosts(
          networkService, userService, status);
      return postDetail;
    } catch (e) {
      logger.v(e);
      rethrow;
    }
  }

  final RxBool loadingPosts = false.obs;

  final RxList<PostModel> posts = <PostModel>[].obs;
}
