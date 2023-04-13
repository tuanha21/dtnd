import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/logic/account_sheet.dart';
import 'package:dtnd/ui/screen/account/sheet/money_statement_sheet.dart';
import 'package:dtnd/ui/screen/account/sheet/share_statement_sheet.dart';
import 'package:dtnd/ui/screen/asset/screen/margin_debt/margin_debt_screen.dart';
import 'package:dtnd/ui/screen/asset/screen/realized_profit_loss/realized_profit_loss.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/screen/order_note_screen.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_util.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/drawer/app_drawer_sub_view.dart';
import 'package:dtnd/ui/widget/drawer/component/list_function.dart';
import 'package:dtnd/ui/widget/drawer/logic/function_data.dart';
import 'package:dtnd/ui/widget/drawer/logic/icon_asset.dart';
import 'package:dtnd/utilities/account_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_image.dart';
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
        const FunctionData(
          title: "Xác thực tài khoản - eKYC",
          iconPath: DrawerIconAsset.verify_account_icon,
        ),
        FunctionData(
          title: 'Giao dịch chứng khoán',
          iconPath: DrawerIconAsset.chart_2,
          function: () {
            // back();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AppDrawerSubView(
                  title: 'Giao dịch chứng khoán',
                  list: <FunctionData>[
                    FunctionData(
                        title: S.current.base_trading,
                        iconPath: DrawerIconAsset.chart_2,
                        function: () {
                          // back();
                          StockModelUtil.openSheet(context);
                        }),
                    FunctionData(
                      title: S.current.derivative_trading,
                      iconPath: DrawerIconAsset.chart_2,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        FunctionData(
          title: S.current.money_trading,
          iconPath: DrawerIconAsset.money_change,
        ),
        FunctionData(
          title: 'Công cụ phân tích',
          iconPath: DrawerIconAsset.setting_3,
          function: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AppDrawerSubView(
                  title: 'Công cụ phân tích',
                  list: <FunctionData>[
                    FunctionData(
                        title: S.current.filter_stock,
                        iconPath: DrawerIconAsset.chart_2,
                        function: () {
                          // back();
                          StockModelUtil.openSheet(context);
                        }),
                  ],
                ),
              ),
            );
          },
        ),
        FunctionData(
            title: S.current.accumulate,
            iconPath: DrawerIconAsset.archive_book),
        FunctionData(
          title: 'Sao kê tài khoản',
          iconPath: DrawerIconAsset.clipboard_text,
          function: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AppDrawerSubView(
                  title: 'Sao kê tài khoản',
                  list: <FunctionData>[
                    FunctionData(
                        title: S.current.money_statement,
                        iconPath: DrawerIconAsset.cashier_report_icon,
                        function: () {
                          const MoneyStatementISheet().show(
                              context, const MoneyStatementSheet(),
                              wrap: false);
                        }),
                    FunctionData(
                      title: S.current.stock_statement,
                      iconPath: DrawerIconAsset.stock_statement_icon,
                      function: () {
                        const ShareStatementISheet().show(
                            context, const ShareStatementSheet(),
                            wrap: false);
                      },
                    ),
                    FunctionData(
                      title: S.current.order_history,
                      iconPath: DrawerIconAsset.profit_loss_history_icon,
                      function: () {
                        // back();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const OrderNoteScreen(defaultab: 2),
                        ));
                      },
                    ),
                    FunctionData(
                      title: S.current.gain_loss_history,
                      iconPath: DrawerIconAsset.profit_loss_history_icon,
                      function: () {
                        // back();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RealizedProfitLoss(),
                        ));
                      },
                    ),
                    FunctionData(
                      title: S.current.margin_debt,
                      iconPath: DrawerIconAsset.profit_loss_history_icon,
                      function: () {
                        // back();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MarginDebtScreen(),
                        ));
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        FunctionData(
          title: S.current.security,
          iconPath: DrawerIconAsset.shield_security,
        ),
        FunctionData(
          title: S.current.setting,
          iconPath: DrawerIconAsset.setting_2,
          function: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AppDrawerSubView(
                  title: S.current.setting,
                  list: <FunctionData>[
                    FunctionData(
                      title: S.current.languges,
                      iconPath: DrawerIconAsset.shield_security,
                    ),
                    FunctionData(
                      title: S.current.interface,
                      iconPath: DrawerIconAsset.shield_security,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ];
    } else {
      list = <FunctionData>[
        FunctionData(
          title: S.current.setting,
          iconPath: DrawerIconAsset.setting_2,
          function: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AppDrawerSubView(
                  title: S.current.setting,
                  list: <FunctionData>[
                    FunctionData(
                        title: S.current.languges,
                        iconPath: DrawerIconAsset.archive_book),
                    FunctionData(
                        title: S.current.interface,
                        iconPath: DrawerIconAsset.archive_book),
                  ],
                ),
              ),
            );
          },
        ),
      ];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = userService.isLogin;
    final info = userService.userInfo.value;

    UserToken userToken;

    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, right: 16, left: 16),
      decoration: const BoxDecoration(color: Colors.white),
      // width: 275,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          DrawerAvatar(info: info),
          const SizedBox(width: 8),
          Text(
            userService.userInfo.value?.customerName ?? "",
            style:
                AppTextStyle.bodyLarge_16.copyWith(color: AppColors.primary_01),
          ),
          const SizedBox(height: 4),
          Text(
            userService.userInfo.value?.customerCode ?? "",
            style:
                AppTextStyle.bodySmall_12.copyWith(color: AppColors.neutral_03),
          ),
          const SizedBox(height: 16),
          isLogin
              ? Material(
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
                          const SizedBox(width: 8),
                          SizedBox.square(
                            dimension: 24,
                            child: Image.asset(
                              AppImages.red_ring_icon,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Bạn chưa xác thực tài khoản",
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
            height: 30,
          ),
          Builder(
            builder: (context) {
              if (isLogin) {
                return const SizedBox();
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text(
              'DTND - 1.0.1',
              style: TextStyle(color: AppColors.neutral_03),
            ),
          ),
          SingleColorTextButton(
            onTap: () {
              back();
              if (isLogin) {
                AccountUtil.logout(context);
              } else {
                Navigator.of(context).push<bool>(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              }
            },
            text: isLogin ? S.of(context).logout : S.of(context).login,
            color: isLogin ? AppColors.neutral_05 : AppColors.primary_01,
            textStyle: AppTextStyle.titleSmall_14
                .copyWith(color: isLogin ? AppColors.primary_01 : Colors.white),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
