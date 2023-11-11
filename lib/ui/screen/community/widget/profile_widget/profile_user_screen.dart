import 'package:dtnd/ui/screen/community/widget/profile_widget/post_screen.dart';
import 'package:dtnd/ui/screen/community/widget/profile_widget/profileAppBarDelegate.dart';
import 'package:dtnd/ui/screen/community/widget/profile_widget/statistics_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../data/i_user_service.dart';
import '../../../../../data/implementations/user_service.dart';
import '../../../home/home_controller.dart';
import 'detail_profile.dart';

class InfoUserScreen extends StatefulWidget {
  const InfoUserScreen({Key? key}) : super(key: key);

  @override
  State<InfoUserScreen> createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<InfoUserScreen>
    with SingleTickerProviderStateMixin {
  final IUserService userService = UserService();
  final HomeController homeController = HomeController();
  late final TabController _tabController;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      scrollDirection: Axis.vertical,
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: InfoAppBarDelegate(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const InfoUser(),
                SizedBox(
                  height: 40,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: false,
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    tabs: const <Widget>[
                      Text("Bài đăng"),
                      Text("Thông"),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: TabBarView(controller: _tabController, children: [
                    PostScreen(scrollController),
                    const StatisticsScreen()
                  ]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
