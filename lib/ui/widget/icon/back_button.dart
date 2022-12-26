import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:flutter/material.dart';

class SheetBackButton extends StatelessWidget {
  const SheetBackButton({
    super.key,
    this.onTap,
  });
  final dynamic onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(BackCmd(onTap)),
      child: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 20,
      ),
    );
  }
}
