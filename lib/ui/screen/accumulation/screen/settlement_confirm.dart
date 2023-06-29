import 'package:dtnd/ui/screen/accumulation/widget/settlement_success_dialog.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../generated/l10n.dart';
import '../controller/accumulation_controller.dart';
import '../widget/row_information.dart';

class SettlementConfirm extends StatefulWidget {
  const SettlementConfirm({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<SettlementConfirm> createState() => _SettlementConfirmState();
}

class _SettlementConfirmState extends State<SettlementConfirm> {
  final AccumulationController _controller = Get.put(AccumulationController());

  double? sum;

  @override
  void initState() {
    super.initState();
    _controller.getSingleContract(widget.id);
    sum = ((double.tryParse(
                _controller.singleContract.value?.cLIQUIDFEE.toString() ??
                    '') ??
            0) +
        (double.tryParse(
                _controller.singleContract.value?.cCAPITAL.toString() ?? '') ??
            0));
  }

  final DateTime nowDate = DateTime.now();

  String getToDay() {
    return DateFormat('dd/MM/yyyy').format(nowDate);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).payment_details,
      ),
      body: SingleChildScrollView(
        child: bodyWidget(textTheme, context),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0, left: 32),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          height: 48,
          width: double.infinity,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.text_blue),
            ),
            onPressed: () {
              _controller
                  .liquidAll(
                      _controller.singleContract.value?.pKCONTRACTBORROW ?? '')
                  .whenComplete(
                    () => showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => const SettlementSuccessDialog(),
                    ),
                  );
            },
            child: Text(S.of(context).confirm),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(TextTheme textTheme, BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 5, bottom: 100.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Text('Số tiền',
              style:
                  textTheme.bodyLarge?.copyWith(color: AppColors.neutral_02)),
          const SizedBox(height: 10),
          Text(
              NumUtils.formatDouble(_controller.singleContract.value?.cCAPITAL),
              style: textTheme.bodyMedium
                  ?.copyWith(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).start_date,
                      style: textTheme.bodySmall
                          ?.copyWith(color: AppColors.neutral_04),
                    ),
                    Text(S.of(context).end_date,
                        style: textTheme.bodySmall
                            ?.copyWith(color: AppColors.neutral_04)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_controller.singleContract.value?.cOPENDATE ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(_controller.singleContract.value?.cEXPIREDATE ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          RowInfomation(
              leftText: S.of(context).accumulated_code,
              rightText: _controller.singleContract.value?.cCONTRACTCODE ?? ''),
          RowInfomation(
              leftText: S.of(context).period,
              rightText: _controller.singleContract.value?.cTERMNAME ?? ''),
          RowInfomation(
              leftText: S.of(context).number_of_days_sent,
              rightText:
                  "${NumUtils.formatInteger(_controller.singleContract.value?.cCURRENTDAY)} ngày"),
          RowInfomation(
              leftText: S.of(context).settlement_date, rightText: getToDay()),
          RowInfomation(
              leftText:
                  '${S.of(context).interest_paid_off_before_maturity} (${_controller.singleContract.value?.cLIQUIDRATE}%/năm)',
              rightText:
                  '${NumUtils.formatDouble(_controller.singleContract.value?.cLIQUIDFEE)}đ'),
          RowInfomation(
              leftText: S.of(context).actually_received,
              rightText: "${NumUtils.formatDouble(sum)}đ"),
        ],
      ),
    );
  }
}
