import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class itemNotification extends StatefulWidget {
  const itemNotification({Key? key}) : super(key: key);

  @override
  State<itemNotification> createState() => _itemNotificationState();
}

class _itemNotificationState extends State<itemNotification> {

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    final formattedDate = dateFormat.format(now);
    final ThemeData themeData = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: themeData.colorScheme.background),
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
                  const Icon(Icons.notification_add),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "MBB - Trả cổ tức theo tỷ lệ 100:15",
                    style: TextStyle(
                        color: themeData.colorScheme.onBackground, fontWeight: FontWeight.bold),
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
            "MBB - Ngân hàng TMCP Quân đội - Ngày 14/7 là ngày giao dịch không hưởng quyền nhận cổ tức, ngày đăng ký cuối cùng là ngày 17/7. Theo đó, cổ tức sẽ trả bằng..",
            style: TextStyle(color: themeData.colorScheme.onBackground),
            maxLines: 3,
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
