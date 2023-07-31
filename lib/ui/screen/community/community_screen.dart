import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/screen/community/livestream_tab.dart';
import 'package:dtnd/ui/screen/community/premium_tab.dart';
import 'package:dtnd/ui/screen/community/widget/notification_widget/notification_page.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../theme/app_color.dart';
import 'community_tab.dart';
import 'copy_trade_tab.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final IDataCenterService dataCenterService = DataCenterService();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.neutral_05,
          ),
          child: TextField(
            onChanged: null,
            enableSuggestions: false,
            decoration: InputDecoration(
              hintText: S.of(context).hide_suggest,
              hintStyle:
                  const TextStyle(color: AppColors.neutral_04, fontSize: 14),
              prefixIcon: const Icon(Icons.search),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
        leading: InkWell(onTap: () {}, child: const Icon(Icons.menu)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
              child: const Icon(Icons.notifications_sharp),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              isScrollable: false,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              padding: const EdgeInsets.only(top: 8),
              tabs: <Widget>[
                Text(S.of(context).propose),
                Text(S.of(context).latest),
                const Text("Premium"),
                const Text("Livestream"),
              ],
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: const [
                CommunityTab(),
                CopyTradeTab(),
                PremiumTab(),
                LiveStreamTab()
              ]),
            )
          ],
        ),
      ),
    );
  }
}
