import 'package:dtnd/=models=/response/market/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/icon/account_icon.dart';
import 'package:dtnd/ui/screen/account/logic/account_extension_button.dart';
import 'package:dtnd/ui/screen/account/logic/account_sheet.dart';
import 'package:dtnd/ui/screen/account/screen/full_extensions_screen.dart';
import 'package:dtnd/ui/screen/account/screen/smartotp_screen/smartotp_screen.dart';
import 'package:dtnd/ui/screen/account/sheet/money_statement_sheet.dart';
import 'package:dtnd/ui/screen/account/sheet/share_statement_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/screen/order_note_screen.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_flow.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import 'package:flutter/material.dart';

class AccountExtensionsWidget extends StatefulWidget {
  const AccountExtensionsWidget({super.key, required this.ctx});
  final BuildContext ctx;
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
      label: S.current.money_statement,
    ),
    AccountExtensionButton(
        icon: AccountIcon.scan,
        label: "SmartOTP",
        route: const SmartotpScreen()),
    AccountExtensionButton(
      icon: AccountIcon.receipt_search,
      label: "Sao kê CK",
    ),
    AccountExtensionButton(
        icon: AccountIcon.more,
        label: S.current.see_more,
        route: const FullExtensionsScreen()),
  ];

  @override
  void initState() {
    super.initState();
    list.first.route = () async {
      final list =
          await dataCenterService.getStocksModelsFromStockCodes(["AAA"]);
      final StockModel? aaa;
      if (list?.isNotEmpty ?? false) {
        aaa = list!.first;
      } else {
        aaa = null;
      }
      if (mounted) {}
      // return StockOrderISheet(widget.stockModel).showSheet(context, );
      StockOrderISheet(null).show(
          widget.ctx,
          StockOrderSheet(
            stockModel: aaa,
            orderData: null,
          ));
    };
    list[6].route = () {
      const MoneyStatementISheet()
          .show(widget.ctx, const MoneyStatementSheet(), wrap: false);
    };

    list[8].route = () {
      const ShareStatementISheet()
          .show(widget.ctx, const ShareStatementSheet(), wrap: false);
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
