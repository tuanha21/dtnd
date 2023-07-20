import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/community/post_model.dart';
import 'package:dtnd/ui/screen/community/widget/profile_widget/profile_user_screen.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/app_color.dart';
import 'post_detail_page.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;

  const PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool showEmoji = false;
  bool like = false;
  List<IconData> emojis = [
    Icons.emoji_emotions,
    Icons.sentiment_very_satisfied,
    Icons.sentiment_satisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_dissatisfied,
  ];
  IconData? selectedEmoji;

  @override
  Widget build(BuildContext context) {
    var bodySmall_12 = Theme.of(context).textTheme.titleSmall;
    return GestureDetector(
      onTap: () {
        setState(() {
          showEmoji = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CommentDetailPage(
                post: widget.post,
              );
            },
          ),
        );
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 18, right: 18, top: 16, bottom: 16),
        decoration: BoxDecoration(
            color: AppColors.light_bg, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InfoUserScreen(),
                    ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 36,
                    width: 36,
                    child: CachedNetworkImage(
                      key: const ObjectKey(
                          'https://nld.mediacdn.vn/291774122806476800/2022/10/20/hinh-0-1666238114349931972391.jpg'),
                      imageUrl:
                          "https://nld.mediacdn.vn/291774122806476800/2022/10/20/hinh-0-1666238114349931972391.jpg",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        decoration: const BoxDecoration(
                            color: AppColors.accent_light_01,
                            shape: BoxShape.circle),
                      ),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.user,
                        style:
                            bodySmall_12?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          SvgPicture.asset(AppImages.clock),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              TimeUtilities.getTimeAgo(
                                  context, widget.post.createTime),
                              style: bodySmall_12?.copyWith(
                                  fontSize: 10, color: AppColors.neutral_03),
                            ),
                          ),
                          const SizedBox(width: 19),
                          // SvgPicture.asset(AppImages.eyes),
                          // const SizedBox(width: 5),
                          // Text(
                          //   NumUtils.formatInteger(post.viewCount),
                          //   style: bodySmall_12?.copyWith(
                          //       fontSize: 10, color: AppColors.neutral_03),
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
                // SvgPicture.asset(AppImages.archive_add)
                InkWell(
                  onTap: () {
                    _showBottomSheetMore(context);
                  },
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.post.content,
                    style: bodySmall_12?.copyWith(fontSize: 12),
                  ),
                )
              ],
            ),

            // const SizedBox(height: 8),
            // Row(
            //   children: [
            //     Text(
            //       'Giá vào',
            //       style: bodySmall_12?.copyWith(
            //           fontSize: 12, color: AppColors.neutral_03),
            //     ),
            //     const SizedBox(width: 4),
            //     Text(
            //       '1.000.000',
            //       style: bodySmall_12?.copyWith(
            //           fontSize: 12, fontWeight: FontWeight.w600),
            //     ),
            //     const SizedBox(width: 46),
            //     Text(
            //       'Lãi/Lỗ',
            //       style: bodySmall_12?.copyWith(
            //           fontSize: 12, color: AppColors.neutral_03),
            //     ),
            //     const SizedBox(width: 4),
            //     SvgPicture.asset(AppImages.arrowUp),
            //     Text(
            //       '16.3%',
            //       style: bodySmall_12?.copyWith(
            //           fontSize: 12,
            //           color: AppColors.semantic_01,
            //           fontWeight: FontWeight.w600),
            //     )
            //   ],
            // ),
            const SizedBox(height: 16),
            Stack(
              children: [
                if (selectedEmoji != null && like == true)
                  Icon(
                    selectedEmoji,
                    color: Colors.blue,
                  ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Icon(
                //       Icons.account_box,
                //       color: Colors.grey,
                //     ),
                //     Text(
                //       NumUtils.formatInteger(widget.post.viewCount),
                //       style: bodySmall_12?.copyWith(
                //           fontSize: 12, color: AppColors.neutral_03),
                //     )
                //   ],
                // ),
                showEmoji ? iconEmoji() : const SizedBox()
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              height: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        like == true
                            ? Icon(
                                selectedEmoji,
                                color: Colors.blue,
                              )
                            : const Icon(
                                Icons.emoji_emotions,
                                color: Colors.grey,
                              ),
                        const SizedBox(width: 5),
                        Text("Thích")
                        // Text(
                        //   NumUtils.formatInteger(post.viewCount),
                        //   style: bodySmall_12?.copyWith(
                        //       fontSize: 12, color: AppColors.neutral_03),
                        // )
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        like = !like;
                        if (!showEmoji) {
                          selectedEmoji = emojis[0];
                        }
                      });
                    },
                    onLongPress: () {
                      setState(() {
                        showEmoji = !showEmoji;
                      });
                    },
                  ),
                ),
                const Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(Icons.mode_comment_rounded, color: Colors.black26),
                        SizedBox(width: 5),
                        Text("Bình luận")
                        // Text(
                        //   NumUtils.formatInteger(post.commentCount),
                        //   style: bodySmall_12?.copyWith(
                        //       fontSize: 12, color: AppColors.neutral_03),
                        // )
                      ],
                    ),
                  ),
                ),
                // Expanded(
                //     child: Row(
                //   children: [
                //     SvgPicture.asset(AppImages.share),
                //     const SizedBox(width: 4),
                //     Text(
                //       NumUtils.formatInteger(post.viewCount),
                //       style: bodySmall_12?.copyWith(
                //           fontSize: 12, color: AppColors.neutral_03),
                //     )
                //   ],
                // )),
                // Expanded(
                //     child: Row(
                //   children: [
                //     SvgPicture.asset(AppImages.heart),
                //     const SizedBox(width: 4),
                //     Text(
                //       '50.5K',
                //       style: bodySmall_12?.copyWith(
                //           fontSize: 12, color: AppColors.neutral_03),
                //     )
                //   ],
                // )),
                InkWell(
                  onTap: () {
                    _showBottomSheetShare(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.send,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Chia sẻ"),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showBottomSheetMore(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.front_hand),
                title: Text('Chặn '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Báo cáo'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.warning),
                title: Text('Báo cáo bài viết này '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheetShare(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Chia sẻ màn hình chụp bài viết'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.link_outlined),
                title: Text('Chia sẻ link bài viết'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget iconEmoji() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: emojis.map((emoji) {
          final isSelected =
              emoji == selectedEmoji; // Check if the emoji is selected
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedEmoji = emoji;
                showEmoji = false;
                like = true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(
                emoji,
                color: isSelected
                    ? Colors.blue
                    : Colors.black, // Change the color of the selected emoji
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
