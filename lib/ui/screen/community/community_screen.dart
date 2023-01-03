import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../generated/l10n.dart';

import '../../theme/app_image.dart';
import '../../widget/my_appbar.dart';
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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MyAppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 16, right: 4),
          child: CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
        titleWidget: Text('Kien Nguyen'),
        title: '',
        actions: [
          SvgPicture.asset(AppImages.search_appbar_icon),
          const SizedBox(
            width: 20,
          ),
          SvgPicture.asset(AppImages.notification_appbar_icon),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              isScrollable: false,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              padding: EdgeInsets.zero,
              tabs: <Widget>[
                Text(S.of(context).community),
                Text(S.of(context).copytrade)
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(controller: _tabController, children: const [
                CommunityTab(),
                CopyTradeTab(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
