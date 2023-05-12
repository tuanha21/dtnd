import 'package:dtnd/=models=/response/community/post_model.dart';
import 'package:dtnd/ui/screen/community/widget/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../community_controller.dart';

class ListCommentTab extends StatefulWidget {
  const ListCommentTab({
    Key? key,
    required this.post,
  }) : super(key: key);
  final PostModel post;

  @override
  State<ListCommentTab> createState() => _ListCommentTabState();
}

class _ListCommentTabState extends State<ListCommentTab>
    with AutomaticKeepAliveClientMixin {
  final CommunityController controller = CommunityController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadComments(recordPerPage: widget.post.comments.length + 5);
    }
  }

  loadComments({int? recordPerPage}) {
    widget.post.loadComments(controller.networkService, controller.userService,
        controller.communityService,
        records: recordPerPage);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () => ListView.separated(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index < widget.post.comments.length) {
                return CommentWidget(
                    comment: widget.post.comments.elementAt(index));
              } else if (index == widget.post.comments.length) {
                return _buildLoader();
              } else {
                return const SizedBox.shrink();
              }
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
            itemCount: widget.post.comments.length),
      ),
    );
  }

  Widget _buildLoader() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: const CircularProgressIndicator(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
