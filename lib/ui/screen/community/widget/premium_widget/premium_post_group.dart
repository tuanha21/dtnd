import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_color.dart';
import '../../../../theme/app_image.dart';

class PremiumPostGroup extends StatefulWidget {
  const PremiumPostGroup({Key? key}) : super(key: key);

  @override
  State<PremiumPostGroup> createState() => _PremiumPostGroupState();
}

class _PremiumPostGroupState extends State<PremiumPostGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Cùng Nhau Đầu Tư Chứng Khoán"),
                      Text("Vũ Trường Linh 9 giờ trước")
                    ],
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue)),
                child: const Text(
                  "Tham gia",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(2),
            width: 110,
            decoration: BoxDecoration(
                color: Colors.amber.shade700,
                borderRadius: BorderRadius.circular(8)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  "Premium Post",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text("Mua quanh giá 18.1 và 18.2 (chốt quyển trả cổ tức)"),
          const SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.home_appbar_bg,
                  fit: BoxFit
                      .cover, // Sử dụng BoxFit.cover để lớp phủ phủ hết ảnh
                ),
              ),
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Premium là tính năng chia sẻ nội dung có thu phí được\n tạo bởi những trưởng phòng có kinh nghiệm và có kiến thức đầu tư được Anfin chọn lọc.',
                        style: TextStyle(
                          color: AppColors.neutral_02,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Kích hoạt gói Premium để xem tiếp.",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text(
                          "Trải ngiệm 3 ngày miễn phí",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            height: 1,
          ),
          const SizedBox(height: 10),
          const Padding(
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
          ),
          const SizedBox(height: 5,)
        ],
      ),
    );
  }
}
