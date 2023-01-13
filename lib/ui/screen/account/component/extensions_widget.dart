import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/icon/account_icon.dart';
import 'package:dtnd/ui/screen/account/logic/account_extension_button.dart';
import 'package:dtnd/ui/screen/account/screen/full_extensions_screen.dart';
import 'package:dtnd/ui/screen/account/screen/smartotp_screen/smartotp_screen.dart';
import 'package:flutter/material.dart';

class AccountExtensionsWidget extends StatefulWidget {
  const AccountExtensionsWidget({super.key});

  @override
  State<AccountExtensionsWidget> createState() =>
      _AccountExtensionsWidgetState();
}

class _AccountExtensionsWidgetState extends State<AccountExtensionsWidget> {
  final List<AccountExtensionButton> list = <AccountExtensionButton>[
    AccountExtensionButton(
      icon: AccountIcon.trend_up,
      label: S.current.order,
    ),
    AccountExtensionButton(
      icon: AccountIcon.book,
      label: S.current.order_note,
    ),
    AccountExtensionButton(
      icon: AccountIcon.clipboard_export,
      label: S.current.order_htr,
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
                            onTap: () {
                              if (list.elementAt(i + j).route != null) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      list.elementAt(i + j).route!,
                                ));
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
