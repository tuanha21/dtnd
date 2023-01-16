import 'package:dtnd/ui/screen/account/account_screen.dart';
import 'package:dtnd/ui/screen/asset/asset_screen.dart';
import 'package:dtnd/ui/screen/community/community_screen.dart';
import 'package:dtnd/ui/screen/home/home_screen.dart';
import 'package:dtnd/ui/screen/home_base/widget/home_base_bottom_nav.dart';
import 'package:dtnd/ui/screen/home_base/widget/home_base_nav.dart';
import 'package:dtnd/ui/screen/market/market_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeBase extends StatefulWidget {
  const HomeBase({super.key});

  @override
  State<HomeBase> createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {
  final Rx<HomeNav> currentHomeNav = Rx<HomeNav>(HomeNav.home);

  final Map<HomeNav, Widget> routeBuilders = const {
    HomeNav.home: HomeScreen(),
    HomeNav.market: MarketScreen(),
    HomeNav.asset: AssetScreen(),
    HomeNav.community: CommunityScreen(),
    HomeNav.account: AccountScreen(),
  };

  void _selectTab(HomeNav homeNav) {
    if (homeNav == currentHomeNav.value) {
      homeNavKeys[homeNav]!.currentState?.popUntil((route) => route.isFirst);
    } else {
      currentHomeNav.value = homeNav;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeBaseKey,
      body: ObxValue<Rx<HomeNav>>(
        (currentHomeNav) {
          return routeBuilders[currentHomeNav.value] ?? const HomeScreen();
        },
        currentHomeNav,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HomeBaseBottomNav(
        currentHomeNav: currentHomeNav,
        onTapped: _selectTab,
      ),
    );
  }
}

class OffStageNavigator extends StatelessWidget {
  const OffStageNavigator({
    super.key,
    required this.homeNav,
    required this.currentHomeNav,
  });
  final HomeNav homeNav;
  final Rx<HomeNav> currentHomeNav;
  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<HomeNav>>(
      (currentHomeNav) {
        return Offstage(
          offstage: currentHomeNav.value != homeNav,
          child: TabNavigator(
            navigatorKey: homeNavKeys[homeNav],
            tabItem: homeNav,
          ),
        );
      },
      currentHomeNav,
    );
  }
}

class TabNavigatorRoutes {
  static const String root = '/';
  static const String home = '/home';
  static const String notificationDetail = '/notificationDetail';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key, this.navigatorKey, required this.tabItem, this.messageID});

  final GlobalKey<NavigatorState>? navigatorKey;
  final HomeNav tabItem;
  final String? messageID;

  void _pushNotificationDetail(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                routeBuilders![TabNavigatorRoutes.notificationDetail]!(
                    context)));
  }

  void _logout(BuildContext context) {
    GoRouter.of(context).go("/SignIn");
  }

  Map<String, WidgetBuilder>? _routeBuilders(BuildContext contex) {
    switch (tabItem) {
      case HomeNav.home:
        return {
          TabNavigatorRoutes.root: (context) => const HomeScreen(),
        };
      case HomeNav.market:
        return {
          TabNavigatorRoutes.root: (context) => const MarketScreen(),
        };
      case HomeNav.asset:
        return {
          TabNavigatorRoutes.root: (context) => const AssetScreen(),
        };
      case HomeNav.community:
        return {
          TabNavigatorRoutes.root: (context) => const CommunityScreen(),
        };
      case HomeNav.account:
        return {
          TabNavigatorRoutes.root: (context) => const AccountScreen(),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => routeBuilders![routeSettings.name]!(context));
      },
    );
  }
}
