import 'package:flutter/material.dart';
import '../../../../../=models=/ui_model/user_cmd.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utilities/error_definition.dart';
import '../../../../widget/overlay/custom_dialog.dart';

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
        title: S.of(context).create_order_failed,
        disableBack: false,
        action: () {
          Navigator.of(context).pop(const BackCmd());
        },
        type: TypeAlert.warning,
        content: getErrorMessage(context, widget.rc),
      ),
    );
  }
}
