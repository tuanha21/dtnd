import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/display/display_screen.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_util.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/drawer/app_drawer_sub_view.dart';
import 'package:dtnd/ui/widget/drawer/component/list_function.dart';
import 'package:dtnd/ui/widget/drawer/logic/function_data.dart';
import 'package:dtnd/ui/widget/drawer/logic/icon_asset.dart';
import 'package:dtnd/utilities/account_util.dart';
import 'package:dtnd/utilities/sign_in_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../screen/account/sheet/money_statement_sheet.dart';
import '../../screen/account/sheet/share_statement_sheet.dart';
import '../../screen/asset/screen/executed_profit_loss/realized_profit_loss.dart';
import '../../screen/asset/screen/margin_debt/margin_debt_screen.dart';
import '../../screen/exchange_stock/order_note/screen/order_note_screen.dart';
import '../../screen/exercise_right/exercise_right_screen.dart';
import '../../screen/language/language_screen.dart';
import '../../theme/app_image.dart';
import 'component/drawer_avatar.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key, this.onLogout, this.drawerRebuild, this.onLogin});

  final VoidCallback? onLogout;
  final VoidCallback? onLogin;

  final VoidCallback? drawerRebuild;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final AppService appService = AppService();
  final IUserService userService = UserService();

  late List<FunctionData> list;

  void back() {
    return Navigator.of(context).pop(true);
  }

  @override
  void initState() {
    super.initState();
  }

  setupListUi(BuildContext context) {
    if (userService.isLogin) {
      list = <FunctionData>[
        FunctionData(
            title: S.of(context).eKYC_quote,
            iconPath: DrawerIconAsset.verify_account_icon,
            subTitle: []),
        FunctionData(
          title: S.of(context).stock_trade,
          iconPath: DrawerIconAsset.chart_2,
          subTitle: [
            FunctionData(
                title: S.of(context).base_trading,
                function: () => StockModelUtil.openSheet(context)),
            FunctionData(
                title: S.of(context).derivative_trading,
                function: () => onDeveloping()),
            FunctionData(
              title: S.of(context).exercise_right,
              function: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ExerciseRightScreen(),
                ),
              ),
            ),
            FunctionData(
                title: S.of(context).transfer_stock,
                function: () => onDeveloping()),
          ],
        ),
        FunctionData(
          title: S.of(context).money_trading,
          iconPath: DrawerIconAsset.money_change,
          subTitle: [],
        ),
        FunctionData(
          title: S.of(context).analysis_tools,
          iconPath: DrawerIconAsset.setting_3,
          subTitle: [
            FunctionData(
                title: S.of(context).filter_stock,
                function: () => onDeveloping()),
          ],
        ),
        FunctionData(
            title: S.of(context).accumulate,
            iconPath: DrawerIconAsset.archive_book,
            subTitle: []),
        FunctionData(
          title: S.of(context).account_statement,
          iconPath: DrawerIconAsset.clipboard_text,
          subTitle: [
            FunctionData(
              title: S.of(context).money_statement,
              function: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MoneyStatementSheet(),
                ),
              ),
            ),
            FunctionData(
              title: S.of(context).stock_statement,
              function: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ShareStatementSheet(),
                ),
              ),
            ),
            FunctionData(
              title: S.of(context).order_history,
              function: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrderNoteScreen(defaultab: 1),
                ),
              ),
            ),
            FunctionData(
              title: S.of(context).gain_loss_history,
              function: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RealizedProfitLoss(),
                ),
              ),
            ),
            FunctionData(
              title: S.of(context).margin_debt,
              function: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MarginDebtScreen(),
                ),
              ),
            ),
          ],
        ),
        FunctionData(
          title: S.of(context).security,
          iconPath: DrawerIconAsset.shield_security,
          subTitle: [
            FunctionData(
                title: "${S.of(context).delete} ${S.of(context).account}",
                function: () => onDeveloping()),
          ],
        ),
        FunctionData(
          title: S.of(context).setting,
          iconPath: DrawerIconAsset.setting_2,
          subTitle: [
            FunctionData(
              title: S.of(context).languge,
              function: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LanguagesScreen(),
                ),
              ),
            ),
            FunctionData(
              title: S.of(context).interface,
              // function: () => onDeveloping(),
              function: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DisplayScreen(),
                ),
              ),
            ),
          ],
        ),
      ];
    } else {
      list = <FunctionData>[
        FunctionData(
          title: S.of(context).setting,
          iconPath: DrawerIconAsset.setting_2,
          function: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AppDrawerSubView(
                  title: S.of(context).setting,
                  list: <FunctionData>[
                    FunctionData(
                        title: S.of(context).languge,
                        iconPath: DrawerIconAsset.archive_book,
                        subTitle: []),
                    FunctionData(
                        title: S.of(context).interface,
                        iconPath: DrawerIconAsset.archive_book,
                        subTitle: []),
                  ],
                ),
              ),
            );
          },
          subTitle: [],
        ),
      ];
    }
  }

  void onDeveloping() {
    Fluttertoast.showToast(
      msg: S.of(context).developing_feature,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    setupListUi(context);
    bool isLogin = userService.isLogin;
    final info = userService.userInfo.value;
    final ThemeData themeData = Theme.of(context);
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, right: 16, left: 16),
      decoration: BoxDecoration(color: themeData.colorScheme.onSurface),
      // width: 275,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          DrawerAvatar(info: info),
          const SizedBox(height: 8),
          Text(
            userService.userInfo.value?.customerName ?? "",
            style:
                AppTextStyle.bodyLarge_16.copyWith(color: AppColors.primary_01),
          ),
          const SizedBox(height: 4),
          Text(
            userService.userInfo.value?.customerCode ?? "",
            style: AppTextStyle.bodySmall_12.copyWith(
                color: themeMode.isLight
                    ? AppColors.neutral_03
                    : AppColors.neutral_07),
          ),
          const SizedBox(height: 16),
          isLogin
              ? Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Ink(
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.accent_light_03,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          SizedBox.square(
                            dimension: 24,
                            child: Image.asset(
                              AppImages.red_ring_icon,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Text(
                            S.of(context).you_have_not_verified_your_account,
                            style: AppTextStyle.bodySmall_12.copyWith(
                                color: AppColors.semantic_03,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
          const SizedBox(
            height: 20,
          ),
          Builder(
            builder: (context) {
              if (isLogin) {
                return const SizedBox();
              } else {
                return SingleColorTextButton(
                  onTap: () {
                    // back();
                    widget.onLogin?.call();
                    // Navigator.of(context).push<bool>(MaterialPageRoute(
                    //   builder: (context) => const LoginScreen(
                    //     toSignup: true,
                    //   ),
                    // ));
                  },
                  text: S.of(context).sign_up,
                  color: AppColors.neutral_05,
                  textStyle: AppTextStyle.titleSmall_14
                      .copyWith(color: AppColors.primary_01),
                );
              }
            },
          ),
          Expanded(child: ListFunction(list: list)),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'IFIS - ${AppService.instance.appVersion}',
              style: const TextStyle(color: AppColors.neutral_03),
            ),
          ),
          SingleColorTextButton(
            onTap: () {
              widget.onLogin?.call();
              // if (isLogin) {
              //   return AccountUtil.logout(context,
              //       afterLogout: widget.onLogout);
              // } else {
              //   Navigator.of(context).push<bool>(
              //     MaterialPageRoute(
              //       builder: (context) => const LoginScreen(),
              //     ),
              //   );
              // }
            },
            text: isLogin ? S.of(context).logout : S.of(context).login,
            color: isLogin
                ? themeMode.isLight
                    ? AppColors.neutral_05
                    : AppColors.bg_share_inside_nav
                : AppColors.primary_01,
            textStyle: AppTextStyle.titleSmall_14
                .copyWith(color: isLogin ? AppColors.primary_01 : Colors.white),
          ),
          const SizedBox(
            height: 16,
          ),
          if (isLogin &&
              (appService.appConfig["in_appstore_review"] ?? false) == true)
            SingleColorTextButton(
              onTap: () {
                back();
                if (isLogin) {
                  return AccountUtil.deleteAccount(context,
                      afterDeletion: widget.onLogout);
                } else {
                  // Navigator.of(context).push<bool>(
                  //   MaterialPageRoute(
                  //     builder: (context) => const LoginScreen(),
                  //   ),
                  // );
                  SigniInUtils.login(context, LocalStorageService());
                }
              },
              text: "${S.of(context).delete} ${S.of(context).account}",
              color: AppColors.neutral_05,
              textStyle: AppTextStyle.titleSmall_14.copyWith(
                color: AppColors.semantic_03,
              ),
            ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
