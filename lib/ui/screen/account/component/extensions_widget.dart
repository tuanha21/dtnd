import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/icon/account_icon.dart';
import 'package:dtnd/ui/screen/account/logic/account_extension_button.dart';
import 'package:dtnd/ui/screen/account/screen/full_extensions_screen.dart';
import 'package:dtnd/ui/screen/account/screen/smartotp_screen/smartotp_screen.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/screen/order_note_screen.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_flow.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/widget/overlay/login_first_dialog.dart';
import 'package:flutter/material.dart';

import '../../../widget/overlay/custom_dialog.dart';

class AccountExtensionsWidget extends StatefulWidget {
  const AccountExtensionsWidget({super.key});

  @override
  State<AccountExtensionsWidget> createState() =>
      _AccountExtensionsWidgetState();
}

class _AccountExtensionsWidgetState extends State<AccountExtensionsWidget> {
  final IUserService userService = UserService();
  final ILocalStorageService localStorageService = LocalStorageService();
  final IDataCenterService dataCenterService = DataCenterService();
  final List<AccountExtensionButton> list = <AccountExtensionButton>[
    AccountExtensionButton(
      icon: AccountIcon.trend_up,
      label: S.current.order,
    ),
    AccountExtensionButton(
      icon: AccountIcon.book,
      label: S.current.order_note,
      route: const OrderNoteScreen(),
    ),
    AccountExtensionButton(
      icon: AccountIcon.clipboard_export,
      label: S.current.order_htr,
      route: const OrderNoteScreen(defaultab: 2),
    ),
    AccountExtensionButton(
      icon: AccountIcon.shield_security,
      label: "eKYC",
    ),
    AccountExtensionButton(
      icon: AccountIcon.money_recive,
      label: S.current.deposite_money,
    ),
    AccountExtensionButton(
      icon: AccountIcon.money_send,
      label: S.current.withdraw_money,
    ),
    AccountExtensionButton(
      icon: AccountIcon.bank,
      label: S.current.bank,
    ),
    AccountExtensionButton(
        icon: AccountIcon.scan,
        label: "SmartOTP",
        route: const SmartotpScreen()),
    AccountExtensionButton(
        icon: AccountIcon.more,
        label: S.current.see_more,
        route: const FullExtensionsScreen()),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list.first.route = () async {
      if (!userService.isLogin) {
        final toLogin = await showDialog<bool>(
          context: context,
          builder: (context) {
            return const LoginFirstDialog();
          },
        );
        if (toLogin ?? false) {
          if (!mounted) return;
          await Navigator.of(context)
              .push<bool>(MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ))
              .then((result) async {
            if ((result ?? false)) {
              setState(() {});
              if (!localStorageService.biometricsRegistered) {
                final reg = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return CustomDialog(
                      textButtonAction: 'Đồng ý',
                      textButtonExit: 'Để sau',
                      title: 'Đăng nhập bằng sinh trắc học',
                      content:
                          'Bạn chưa đăng ký đăng nhập bằng sinh trắc học\nBạn có muốn đăng ký ngay bây giờ không?',
                      action: () => Navigator.of(context).pop(true),
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
              return list.first.route.call();
            }
          });
        }
      } else {
        final list =
            await dataCenterService.getStockModelsFromStockCodes(["AAA"]);
        final StockModel? aaa;
        if (list?.isNotEmpty ?? false) {
          aaa = list!.first;
        } else {
          aaa = null;
        }
        if (mounted) {}
        // return StockOrderISheet(widget.stockModel).showSheet(context, );
        StockOrderISheet(null).show(
            context,
            StockOrderSheet(
              stockModel: aaa,
              orderData: null,
            ));
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          for (int i = 0; i < list.length; i += 4)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int j = 0; j < 4; j++)
                    if (i + j < list.length)
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              final route = list.elementAt(i + j).route;
                              if (route is Widget) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      list.elementAt(i + j).route!,
                                ));
                              } else if (route is Function) {
                                route.call();
                              }
                            },
                            child: Ink(
                              child: Column(
                                children: [
                                  Image.asset(
                                    list.elementAt(i + j).icon,
                                    width: 28,
                                    height: 28,
                                  ),
                                  Text(list.elementAt(i + j).label),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: Container(),
                      )
                ],
              ),
            )
        ],
      ),
    );
  }
}
