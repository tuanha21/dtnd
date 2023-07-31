import 'package:dtnd/=models=/response/community/post_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/community/community_controller.dart';
import 'package:dtnd/ui/screen/community/widget/post_detail_widget.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppbar(
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
              tabs: [Text(S.of(context).comment), Text(S.of(context).share)],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    Flexible(
                      child: ListCommentTab(
                        post: widget.post,
                      ),
                    ),
                  ],
                ),
              ),
              Container()
            ]),
          ),
          Container(
            alignment: Alignment.center,
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    controller.pickImage();
                  },
                  child: const Icon(
                    Icons.photo_camera,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.gif_box_outlined,
                  size: 30,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    cursorColor: Colors.red,
                    decoration: InputDecoration(
                      counterText: '',
                      suffixIcon: const Icon(Icons.send),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      disabledBorder: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      hintText: "Nhập bình luận...",
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
