import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/ui/widget/overlay/custom_dialog.dart';
import 'package:dtnd/utilities/error_definition.dart';
import 'package:flutter/material.dart';

class StockOrderFailSheet extends StatefulWidget {
  const StockOrderFailSheet({
    super.key,
    required this.rc,
  });
  final int rc;

  @override
  State<StockOrderFailSheet> createState() => _StockOrderFailSheetState();
}

class _StockOrderFailSheetState extends State<StockOrderFailSheet>
    with OrderMessage {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomDialog(
        title: 'Đặt lệnh không thành công',
        disableBack: true,
        action: () {
          Navigator.of(context).pop(const BackCmd());
        },
        type: TypeAlert.warning,
        content: getErrorMessage(context, widget.rc),
      ),
    );
  }
}
