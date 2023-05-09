import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/community/post_comment_model.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/app_color.dart';

class CommentWidget extends StatelessWidget {
  final PostCommentModel comment;
  const CommentWidget({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bodySmall_12 = Theme.of(context).textTheme.titleSmall;
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 16, bottom: 16),
      decoration: BoxDecoration(
          color: AppColors.light_bg, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
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
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.user,
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
                                context, comment.createTime),
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
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  comment.comment,
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
          Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  SvgPicture.asset(AppImages.eyes),
                  const SizedBox(width: 4),
                  Text(
                    "0",
                    style: bodySmall_12?.copyWith(
                        fontSize: 12, color: AppColors.neutral_03),
                  )
                ],
              )),
              Expanded(
                  child: Row(
                children: [
                  SvgPicture.asset(AppImages.message2),
                  const SizedBox(width: 4),
                  Text(
                    "0",
                    style: bodySmall_12?.copyWith(
                        fontSize: 12, color: AppColors.neutral_03),
                  )
                ],
              )),
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
              SvgPicture.asset(AppImages.more),
            ],
          )
        ],
      ),
    );
  }
}
