import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/icon/account_icon.dart';
import 'package:flutter/material.dart';

class SmartotpRegistedCatalog extends StatefulWidget {
  const SmartotpRegistedCatalog({
    super.key,
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  State<SmartotpRegistedCatalog> createState() =>
      _SmartotpRegistedCatalogState();
}

class _SmartotpRegistedCatalogState extends State<SmartotpRegistedCatalog> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AccountIcon.scene,
          width: 170,
        ),
        const SizedBox(height: 16),
        Text(
          S.of(context).success,
          style: textTheme.labelLarge,
        ),
        const SizedBox(height: 16),
        Text(
          S.of(context).successful_registration_for_smart_otp_generation,
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: widget.onClose, child: Text(S.of(context).confirm))
          ],
        )
      ],
    );
  }
}
