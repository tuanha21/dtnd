import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/icon/account_icon.dart';
import 'package:dtnd/ui/screen/account/logic/account_extension_button.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';

import 'biometrics_register/biometrics_register_screen.dart';

class FullExtensionsScreen extends StatefulWidget {
  const FullExtensionsScreen({Key? key}) : super(key: key);

  @override
  State<FullExtensionsScreen> createState() => _FullExtensionsScreenState();
}

class _FullExtensionsScreenState extends State<FullExtensionsScreen> {
  final Map<String, List<AccountExtensionButton>> data = {
    "Giao dịch cổ phiếu": [
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
    ],
    "Giao dịch tiền": [
      AccountExtensionButton(
        icon: AccountIcon.money_recive,
        label: S.current.deposite_money,
      ),
      AccountExtensionButton(
        icon: AccountIcon.money_send,
        label: S.current.withdraw_money,
      ),
      AccountExtensionButton(
        icon: AccountIcon.money_change,
        label: "Ứng trước tiền bán",
      ),
      AccountExtensionButton(
        icon: AccountIcon.shield,
        label: "Quyền",
      ),
      AccountExtensionButton(
        icon: AccountIcon.bank,
        label: S.current.bank,
      ),
    ],
    "Quản lý tài khoản": [
      AccountExtensionButton(
        icon: AccountIcon.receipt_search,
        label: "LS giao dịch",
      ),
      AccountExtensionButton(
        icon: AccountIcon.graph,
        label: "TS cơ sở",
      ),
      AccountExtensionButton(
        icon: AccountIcon.dollar_circle,
        label: "Tổng quan tài sản",
      ),
      AccountExtensionButton(
        icon: AccountIcon.chart_2,
        label: "TS phái sinh",
      ),
      AccountExtensionButton(
        icon: AccountIcon.chart,
        label: "TS copytrade",
      ),
    ],
    "Trung tâm trợ giúp": [
      AccountExtensionButton(
        icon: AccountIcon.security_user,
        label: "Điều khoản",
      ),
      AccountExtensionButton(
        icon: AccountIcon.archive_book,
        label: "Hợp đồng",
      ),
    ],
    "Cài đặt và bảo mật": [
      AccountExtensionButton(
        icon: AccountIcon.scan,
        label: "SmartOTP",
      ),
      AccountExtensionButton(
        icon: AccountIcon.shield_security,
        label: "eKYC",
      ),
      AccountExtensionButton(
        icon: AccountIcon.password_check,
        label: "Đặt lại MK",
      ),
      AccountExtensionButton(
        icon: AccountIcon.finger_cricle,
        label: "Face/Touch ID",
        route: const BiometricsRegisterScreen(),
      ),
      // AccountExtensionButton(
      //     icon: AccountIcon.more,
      //     label: S.current.see_more,
      //     route: const FullExtensionsScreen()),
    ],
  };
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).see_more,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            for (int i = 0; i < data.keys.toList().length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          data.keys.toList().elementAt(i),
                          style: textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _Panel(
                      list: data.values.toList().elementAt(i),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({Key? key, required this.list})
      : super(
          key: key,
        );
  final List<AccountExtensionButton> list;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
      ),
      // child: Wrap(
      //   // alignment: WrapAlignment.spaceBetween,
      //   children: [
      //     for (int i = 0; i < list.length; i++)
      //       Material(
      //         color: Colors.transparent,
      //         child: InkWell(
      //           onTap: () {
      //             if (list.elementAt(i).route != null) {
      //               Navigator.of(context).push(MaterialPageRoute(
      //                 builder: (context) => list.elementAt(i).route!,
      //               ));
      //             }
      //           },
      //           child: Ink(
      //             width: 80,
      //             height: 62,
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Image.asset(
      //                   list.elementAt(i).icon,
      //                   width: 28,
      //                   height: 28,
      //                 ),
      //                 Text(
      //                   list.elementAt(i).label,
      //                   textAlign: TextAlign.center,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //   ],
      // ),
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
                              width: 80,
                              height: 62,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    list.elementAt(i + j).icon,
                                    width: 28,
                                    height: 28,
                                  ),
                                  Text(
                                    list.elementAt(i + j).label,
                                    textAlign: TextAlign.center,
                                  ),
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
