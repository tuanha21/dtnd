import 'package:dtnd/=models=/response/community/post_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/community/community_controller.dart';
import 'package:dtnd/ui/screen/community/widget/post_detail_widget.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../../../widget/my_appbar.dart';
import 'list_comment_tab.dart';

class CommentDetailPage extends StatefulWidget {
  const CommentDetailPage({Key? key, required this.post}) : super(key: key);
  final PostModel post;

  @override
  State<CommentDetailPage> createState() => _CommentDetailPageState();
}

class _CommentDetailPageState extends State<CommentDetailPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final CommunityController controller = CommunityController();

  @override
  void initState() {
    widget.post.viewCount++;
    controller.getPostDetail(widget.post);
    widget.post.loadComments(controller.networkService, controller.userService,
        controller.communityService);
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // controller.refresh();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: S.of(context).article_details,
      ),
      body: Column(
        children: [
          PostDetailWidget(
            post: widget.post,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.light_tabBar_bg),
            child: TabBar(
              controller: _tabController,
              unselectedLabelStyle: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
              labelStyle: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
              indicatorColor: AppColors.text_blue,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.text_blue),
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: const EdgeInsets.symmetric(vertical: 4),
              labelColor: AppColors.light_bg,
              unselectedLabelColor: AppColors.text_black,
              tabs: const [Text("Bình luận"), Text("Chia sẻ")],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              ListCommentTab(
                post: widget.post,
              ),
              Container()
            ]),
          )
        ],
      ),
    );
  }
}
