import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../generated/l10n.dart';

class itemCommunity extends StatefulWidget {
  const itemCommunity({Key? key}) : super(key: key);

  @override
  State<itemCommunity> createState() => _itemCommunityState();
}

class _itemCommunityState extends State<itemCommunity> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    final formattedDate = dateFormat.format(now);
    final ThemeData themeData = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: themeData.colorScheme.background),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.group),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(Icons.terrain),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    S.of(context).new_post,
                    style: TextStyle(
                        color: themeData.colorScheme.onBackground,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Icon(
                Icons.circle,
                size: 10,
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Trưởng phòng Phạm Trung Hiếu vừa chia sẻ bài viết mới Khuyến nghị mua MSH Múc SHA",
            style: TextStyle(color: themeData.colorScheme.onBackground),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            formattedDate,
            style: TextStyle(color: Colors.grey.shade500),
          )
        ],
      ),
    );
  }
}
