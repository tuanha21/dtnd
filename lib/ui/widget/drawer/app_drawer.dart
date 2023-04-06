import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/icon/account_icon.dart';
import 'package:dtnd/ui/screen/account/logic/account_sheet.dart';
import 'package:dtnd/ui/screen/account/screen/biometrics_register/biometrics_register_screen.dart';
import 'package:dtnd/ui/screen/account/sheet/money_statement_sheet.dart';
import 'package:dtnd/ui/screen/account/sheet/share_statement_sheet.dart';
import 'package:dtnd/ui/screen/account/sheet/sheet_config.dart';
import 'package:dtnd/ui/screen/account/sheet/user_info_detail_sheet.dart';
import 'package:dtnd/ui/screen/asset/screen/margin_debt/margin_debt_screen.dart';
import 'package:dtnd/ui/screen/asset/screen/realized_profit_loss/realized_profit_loss.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/screen/order_note_screen.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_util.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/drawer/component/list_function.dart';
import 'package:dtnd/ui/widget/drawer/logic/function_data.dart';
import 'package:dtnd/ui/widget/drawer/logic/icon_asset.dart';
import 'package:dtnd/utilities/account_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'component/drawer_avatar.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final IUserService userService = UserService();

  late final List<FunctionData> list;

  void back() {
    return Navigator.of(context).pop();
  }

  @override
  void initState() {
    if (userService.isLogin) {
      list = <FunctionData>[
        FunctionData(
          title: S.current.stock_trading,
          iconPath: DrawerIconAsset.chart_2,
          subFunction: [
            FunctionData(
                title: S.current.base_trading,
                function: () {
                  back();
                  StockModelUtil.openSheet(context);
                }),
            FunctionData(
              title: S.current.derivative_trading,
            ),
          ],
        ),
        FunctionData(
            title: S.current.money_trading,
            iconPath: DrawerIconAsset.money_change),
        FunctionData(
          title: S.current.stock_analysis,
          iconPath: DrawerIconAsset.setting_3,
          subFunction: [
            FunctionData(
              title: S.current.filter_stock,
            ),
          ],
        ),
        FunctionData(
            title: S.current.accumulate,
            iconPath: DrawerIconAsset.archive_book),
        FunctionData(
          title: S.current.lookup,
          iconPath: DrawerIconAsset.clipboard_text,
          subFunction: [
            FunctionData(
                title: S.current.money_statement,
                function: () {
                  const MoneyStatementISheet()
                      .show(context, const MoneyStatementSheet(), wrap: false);
                }),
            FunctionData(
              title: S.current.stock_statement,
              function: () {
                const ShareStatementISheet()
                    .show(context, const ShareStatementSheet(), wrap: false);
              },
            ),
            FunctionData(
              title: S.current.order_history,
              function: () {
                back();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OrderNoteScreen(defaultab: 2),
                ));
              },
            ),
            FunctionData(
              title: S.current.gain_loss_history,
              function: () {
                back();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RealizedProfitLoss(),
                ));
              },
            ),
            FunctionData(
              title: S.current.margin_debt,
              function: () {
                back();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MarginDebtScreen(),
                ));
              },
            ),
          ],
        ),
        FunctionData(
          title: S.current.security,
          iconPath: DrawerIconAsset.shield_security,
          subFunction: [
            FunctionData(
              title:
                  "${S.current.change_password}/ ${S.current.order_orders_pin.toLowerCase()}",
            ),
            const FunctionData(
              title: "Smart OTP",
            ),
            FunctionData(
                title:
                    "${S.current.login} ${S.current.by} ${S.current.biomestric.toLowerCase()}",
                function: () {
                  back();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const BiometricsRegisterScreen(),
                  ));
                }),
          ],
        ),
        FunctionData(
          title: S.current.setting,
          iconPath: DrawerIconAsset.setting_2,
          subFunction: [
            FunctionData(
              title: S.current.languges,
            ),
            FunctionData(
              title: S.current.interface,
            ),
          ],
        ),
      ];
    } else {
      list = <FunctionData>[
        FunctionData(
          title: S.current.setting,
          iconPath: DrawerIconAsset.setting_2,
          subFunction: [
            FunctionData(
                title: S.current.languges,
                iconPath: DrawerIconAsset.archive_book),
            FunctionData(
                title: S.current.interface,
                iconPath: DrawerIconAsset.archive_book),
          ],
        ),
      ];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool isLogin = userService.isLogin;
    const String version = "0.0.1";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(color: Colors.white),
      width: 275,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const DrawerAvatar(),
          Builder(
            builder: (context) {
              final info = userService.userInfo.value;
              if (isLogin) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          info?.custFullName ?? "",
                          style: textTheme.titleSmall!.copyWith(
                              fontSize: 16,
                              color: AppColors.primary_01,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          info?.customerCode ?? "",
                          style: textTheme.displaySmall!.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Material(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: InkWell(
                        onTap: () {
                          const UserInfoDetailISheet().show(
                              context, UserInfoDetailSheet(userInfo: info),
                              wrap: false);
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: AppColors.accent_light_04,
                          ),
                          child: Image.asset(
                            AccountIcon.people,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return SingleColorTextButton(
                  onTap: () {
                    back();
                    GoRouter.of(context).push('/SignUp');
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
          SizedBox(
            height: 100,
            child: Column(
              children: [
                const Text("DTND - $version"),
                SingleColorTextButton(
                  onTap: () {
                    back();
                    if (isLogin) {
                      AccountUtil.logout(context);
                    } else {
                      Navigator.of(context).push<bool>(MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                    }
                  },
                  text: isLogin ? S.of(context).logout : S.of(context).login,
                  color: isLogin ? AppColors.neutral_05 : AppColors.primary_01,
                  textStyle: AppTextStyle.titleSmall_14.copyWith(
                      color: isLogin ? AppColors.primary_01 : Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
