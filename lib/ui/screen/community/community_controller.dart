import 'dart:io';

import 'package:dtnd/=models=/response/community/post_model.dart';
import 'package:dtnd/data/i_community_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CommunityController {
  static final CommunityController _instance = CommunityController._intern();

  final INetworkService networkService = NetworkService();

  final IUserService userService = UserService();

  final ICommunityService communityService = ICommunityService();

  final ScrollController scrollController = ScrollController();

  CommunityController._intern();

  factory CommunityController() => _instance;

  final Rx<File?> image = Rx<File?>(null);

  Future<void> init() async {
    await getPosts();
  }

  Future<void> refresh() async {
    posts.clear();
    await getPosts();
  }

  Future<void> getPosts({int? recordPerPage}) async {
    if (loadingPosts.value) {
      return;
    }
    try {
      loadingPosts.value = true;

      final posts =
          await communityService.loadPosts(networkService, userService,records: recordPerPage);
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

  void scrollListener() {
    if (scrollController.offset >=
        scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
       getPosts(
          recordPerPage: posts.length + 5);
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image.value = File(pickedImage.path);
    }
  }

  Future<void> takePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      image.value = File(pickedImage.path);
    }
  }

  void clearImage() {
    image.value = null;
  }

}
