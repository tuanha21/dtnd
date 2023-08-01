import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/asset_screen.dart';
import 'package:dtnd/ui/screen/community/community_screen.dart';
import 'package:dtnd/ui/screen/home/home_screen.dart';
import 'package:dtnd/ui/screen/home_base/widget/home_base_bottom_nav.dart';
import 'package:dtnd/ui/screen/home_base/widget/home_base_nav.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/screen/market/market_screen.dart';
import 'package:dtnd/ui/widget/drawer/app_drawer.dart';
import 'package:dtnd/ui/widget/overlay/dialog_utilities.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/sign_in_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final sessionExpiredKey = GlobalKey();

class HomeBase extends StatefulWidget {
  const HomeBase({super.key});

  @override
  State<HomeBase> createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> with WidgetsBindingObserver {
  final INetworkService networkService = NetworkService();
  final IUserService userService = UserService();
  final Rx<HomeNav> currentHomeNav = Rx<HomeNav>(HomeNav.home);

  bool onSessionExpiredCalled = false;
  bool isLogin = false;

  late final Map<HomeNav, Widget> routeBuilders;

  void _selectTab(HomeNav homeNav) {
    if (homeNav == currentHomeNav.value) {
      homeNavKeys[homeNav]!.currentState?.popUntil((route) => route.isFirst);
    } else {
      currentHomeNav.value = homeNav;
    }
  }

  void onSessionExpired() async {
    logger.v("onSessionExpired called!");
    if (onSessionExpiredCalled) {
      return;
    }
    onSessionExpiredCalled = true;
    if (!mounted) {
      return;
    }
    userService.deleteToken();
    await DialogUtilities.showErrorDialog(
        key: sessionExpiredKey,
        context: context,
        title: S.of(context).something_went_wrong,
        content: S.of(context).session_had_been_expired);
    if (!mounted) return;
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
    onSessionExpiredCalled = false;
  }

  void onLogin(BuildContext context) =>
      SigniInUtils.login(context, LocalStorageService());

  @override
  void initState() {
    routeBuilders = {
      HomeNav.home: HomeScreen(
        navigateTab: _selectTab,
      ),
      HomeNav.market: const MarketScreen(),
      HomeNav.asset: const AssetScreen(),
      HomeNav.community: const CommunityScreen(),
      // HomeNav.account: const AccountScreen(),
    };
    super.initState();
    WidgetsBinding.instance
      ..addObserver(this)
      ..addPostFrameCallback((timeStamp) {
        networkService.regSessionExpiredCallback(onSessionExpired);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeBaseKey,
      drawer: AppDrawer(
        onLogout: () => setState(() {
          isLogin = false;
        }),
        onLogin: () {
          Navigator.of(context).pop();
          onLogin(context);
        },
      ),
      body: ObxValue<Rx<HomeNav>>(
        (currentHomeNav) {
          return routeBuilders[currentHomeNav.value] ??
              HomeScreen(
                navigateTab: _selectTab,
              );
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
