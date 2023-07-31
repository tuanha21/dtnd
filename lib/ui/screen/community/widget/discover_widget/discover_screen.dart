import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/ui/screen/community/widget/filter_widget/filter_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../theme/app_color.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        title: Text(
          S.of(context).discover,
          style: const TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FilterScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.filter_list_alt,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              4,
              (index) => itemDiscover(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemDiscover(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Column(
      children: [
        const SizedBox(
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
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  decoration: const BoxDecoration(
                    color: AppColors.accent_light_01,
                    shape: BoxShape.circle,
                  ),
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
                const Text(
                  "Chứng khoán F0 (Mầm non chứng khoán)",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                        TextSpan(
                        text: "1822",
                        style: TextStyle(color: themeData.colorScheme.onBackground),
                      ),
                      TextSpan(
                        text: " thành viên",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 20,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return itemTag(context);
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 5,
          color: Colors.grey,
        )
      ],
    );
  }

  Widget itemTag(context) {
    final ThemeData themeData = Theme.of(context);
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(S.of(context).news_every_day,style: TextStyle(color: themeData.colorScheme.background),),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
