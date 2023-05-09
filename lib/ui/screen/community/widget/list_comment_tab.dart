import 'package:dtnd/=models=/response/community/post_model.dart';
import 'package:dtnd/ui/screen/community/widget/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListCommentTab extends StatefulWidget {
  const ListCommentTab({Key? key, required this.post}) : super(key: key);
  final PostModel post;
  @override
  State<ListCommentTab> createState() => _ListCommentTabState();
}

class _ListCommentTabState extends State<ListCommentTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(() => ListView.separated(
          itemBuilder: (context, index) {
            return CommentWidget(
                comment: widget.post.comments.elementAt(index));
          },
          separatorBuilder: (context, index) => const SizedBox(
                height: 8,
              ),
          itemCount: widget.post.comments.length)),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
