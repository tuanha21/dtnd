import 'package:dtnd/=models=/response/market/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/functional/tour_guide/tour_guide.dart';
import 'package:dtnd/ui/screen/asset/asset_screen.dart';
import 'package:dtnd/ui/screen/community/community_screen.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_flow.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import 'package:dtnd/ui/screen/home/home_screen.dart';
import 'package:dtnd/ui/screen/home_base/widget/home_base_bottom_nav.dart';
import 'package:dtnd/ui/screen/home_base/widget/home_base_nav.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/screen/market/market_screen.dart';
import 'package:dtnd/ui/screen/tour_guide/app_tutorial.dart';
import 'package:dtnd/ui/screen/tour_guide/widget/target_focus_builder.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/drawer/app_drawer.dart';
import 'package:dtnd/ui/widget/overlay/custom_dialog.dart';
import 'package:dtnd/ui/widget/overlay/dialog_utilities.dart';
import 'package:dtnd/ui/widget/overlay/login_first_dialog.dart';
import 'package:dtnd/utilities/sign_in_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

final sessionExpiredKey = GlobalKey();

class HomeBase extends StatefulWidget {
  const HomeBase({super.key});

  @override
  State<HomeBase> createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> with WidgetsBindingObserver {
  final String identify = "login_required_id";
  final INetworkService networkService = NetworkService();
  final IUserService userService = UserService();
  final Rx<HomeNav> currentHomeNav = Rx<HomeNav>(HomeNav.home);
  final ILocalStorageService localStorageService = LocalStorageService();
  final IDataCenterService dataCenterService = DataCenterService();

  final GlobalKey fabKey = GlobalKey();

  bool onSessionExpiredCalled = false;
  bool isLogin = false;

  late final Map<HomeNav, Widget> routeBuilders;

  final List<TargetFocus> targets = [];

  void _selectTab(HomeNav homeNav) {
    if (homeNav == currentHomeNav.value) {
      homeNavKeys[homeNav]!.currentState?.popUntil((route) => route.isFirst);
    } else {
      currentHomeNav.value = homeNav;
    }
  }

  void onSessionExpired() async {
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
        if (localStorageService.firstTimeOpenApp) {
          startTourrGuide();
        }
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
      body: Scaffold(
        body: ObxValue<Rx<HomeNav>>(
          (current) {
            return routeBuilders[current.value] ??
                HomeScreen(
                  navigateTab: _selectTab,
                );
          },
          currentHomeNav,
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: SizedBox.square(
            key: fabKey,
            dimension: 40,
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                onTap: _onFABTapped,
                child: Ink(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: AppColors.primary_01,
                  ),
                  child: SvgPicture.asset(
                    AppImages.arrange_circle,
                  ),
                  // child: SvgPicture.asset(
                  //   AppImages.arrange_circle,
                  // ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HomeBaseBottomNav(
        add: targets.add,
        currentHomeNav: currentHomeNav,
        onTapped: _selectTab,
      ),
    );
  }

  void _onFABTapped({void Function(List<TargetFocus>)? onTourGuide}) async {
    if (!userService.isLogin) {
      final toLogin = await showDialog<bool>(
        context: context,
        builder: (context) {
          return const LoginFirstDialog();
        },
      );
      if (toLogin ?? false) {
        if (!mounted) return;
        Navigator.of(context)
            .push<bool>(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ))
            .then((result) async {
          if ((result ?? false)) {
            setState(() {});
            if (!localStorageService.biometricsRegistered &&
                localStorageService.isDeviceSupport) {
              final reg = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return CustomDialog(
                    textButtonAction: S.of(context).ok,
                    textButtonExit: S.of(context).later,
                    title: S.of(context).biometric_authentication,
                    content: S.of(context).login_with_biometric,
                    action: () {
                      Navigator.of(context).pop(true);
                    },
                    type: TypeAlert.notification,
                  );
                },
              );
              if (reg ?? false) {
                if (!mounted) return;
                final auth = await localStorageService
                    .biometricsValidate()
                    .onError((error, stackTrace) => false);
                if (auth) {
                  await localStorageService.registerBiometrics();
                }
              }
            }
            return _onFABTapped(onTourGuide: onTourGuide);
          }
          return _onFABTapped();
        });
      }
    } else {
      final list =
          await dataCenterService.getStocksModelsFromStockCodes(["AAA"]);
      final StockModel? aaa;
      if (list?.isNotEmpty ?? false) {
        aaa = list!.first;
      } else {
        aaa = null;
      }
      if (mounted) {
        // return StockOrderISheet(widget.stockModel).showSheet(context, );
        StockOrderISheet(null)
            .show(
                context,
                StockOrderSheet(
                  stockModel: aaa,
                  orderData: null,
                  onGuide: onTourGuide,
                ))
            .then((value) => userService.defaultAccount.value
                ?.refreshAsset(userService, networkService)
                .then((value) => setState(() {})));
      }
    }
  }

  void startTourrGuide() {
    AppTutorial.showWelcome(
      context,
      onNext: () {
        final List<TargetFocusBuilder> targets = [
          TargetFocusBuilder(
            identify: identify,
            keyTarget: fabKey,
            align: ContentAlign.top,
            content: S.of(context).tour_guide1,
            shape: ShapeLightFocus.RRect,
            nextLabel: S.of(context).login,
          ),
        ];

        AppTutorial.addTargets(targets);

        AppTutorial.showTutorial(
          context,
          onBuildNext: (p0) {
            return _onFABTapped(
              onTourGuide: (targets) {},
            );
          },
          onClickTarget: (target) {
            if (target.identify == identify) {
              _onFABTapped(
                onTourGuide: (targets) {},
              );
            }
          },
        );
      },
    );
  }
}
