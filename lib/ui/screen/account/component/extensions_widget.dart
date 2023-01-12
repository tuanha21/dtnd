import 'package:dtnd/ui/screen/account/logic/account_extension_button.dart';
import 'package:flutter/material.dart';

class AccountExtensionsWidget extends StatelessWidget {
  AccountExtensionsWidget({super.key});

  // final list = <IAccountExtensionButton>[StockAccountExtensionButton(icon: , label: '')];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Wrap(),
    );
  }
}
