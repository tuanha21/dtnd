import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_color.dart';

class SinglePost extends StatefulWidget {
  const SinglePost({Key? key}) : super(key: key);

  @override
  State<SinglePost> createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nguyễn Duy Phú"),
                          Text("@phu_le 30-06-2023")
                        ],
                      )
                    ],
                  ),
                  Icon(Icons.more_vert)
                ],
              ),
            ],
          ),
          Text(
              "Chia buồn cho những ai chê quà nhé ạ !!\nTối nay 20h30 e Hiếu live cả nhà vào ủng hộ e hiếu tặng quà nhé ạ"),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.back_hand_outlined, color: Colors.black26),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Thích")
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.mode_comment_rounded, color: Colors.black26),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Bình luận")
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.send,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Chia sẻ")
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
