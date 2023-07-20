import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/ui/screen/community/widget/filter_widget/filter_screen.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_color.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Khám phá"),
        centerTitle: true,
        actions: [
          // Add the action icon here
          IconButton(
            onPressed: () {
              // Handle the filtering action here
            },
            icon: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FilterScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.filter_list_alt,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              itemDiscover(context),
              itemDiscover(context),
              itemDiscover(context),
              itemDiscover(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemDiscover(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
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
                      color: AppColors.accent_light_01, shape: BoxShape.circle),
                ),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Chứng khoán F0 (Mầm non chứng khoán)"),
                Text("1822 Thành viên")
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 20,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return itemTag();
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 5,
        )
      ],
    );
  }

  Widget itemTag() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12)),
          child: Text("Tin tức mỗi ngày"),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
