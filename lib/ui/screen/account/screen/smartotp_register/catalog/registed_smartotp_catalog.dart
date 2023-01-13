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
          "Thành công",
          style: textTheme.labelLarge,
        ),
        const SizedBox(height: 16),
        Text(
          "Đăng ký sinh Smart OTP thành công.",
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: widget.onClose, child: const Text("Xác nhận"))
          ],
        )
      ],
    );
  }
}
