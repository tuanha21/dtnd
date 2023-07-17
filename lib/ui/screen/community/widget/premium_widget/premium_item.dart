import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_color.dart';

class PremiumItem extends StatefulWidget {
  const PremiumItem({Key? key}) : super(key: key);

  @override
  State<PremiumItem> createState() => _PremiumItemState();
}

class _PremiumItemState extends State<PremiumItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(8),
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.neutral_07,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 5,
          ),
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
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => Container(
                decoration: const BoxDecoration(
                    color: AppColors.accent_light_01, shape: BoxShape.circle),
              ),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Cộng đồng chơi đớ toàn quốc",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 3,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.group),
              SizedBox(
                width: 5,
              ),
              Text("841")
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Phí:",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              Text(
                " ${9}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.diamond,
                size: 16,
              ),
              Text(
                "/tuần",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.semantic_04,
                borderRadius: BorderRadius.circular(8)),
            child: const Text(
              "Xem ngay",
              style: TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
