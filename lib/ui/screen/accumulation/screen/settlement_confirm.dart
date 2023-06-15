import 'package:dtnd/ui/screen/accumulation/widget/settlement_success_dialog.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:k_chart/flutter_k_chart.dart';
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
                _controller.singleContract?.cLIQUIDFEE.toString() ?? '') ??
            0) +
        (double.tryParse(
                _controller.singleContract?.cCAPITAL.toString() ?? '') ??
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
      appBar: const SimpleAppbar(
        title: 'Chi tiết tất toán',
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
                  .liquidAll(_controller.singleContract?.pKCONTRACTBORROW ?? '')
                  .whenComplete(() => showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => const SettlementSuccessDialog()));
            },
            child: const Text('Xác nhận'),
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
          Text(NumUtils.formatDouble(_controller.singleContract?.cCAPITAL),
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ngày bắt đầu',
                    style: textTheme.bodySmall
                        ?.copyWith(color: AppColors.neutral_04),
                  ),
                  Text('Ngày kết thúc',
                      style: textTheme.bodySmall
                          ?.copyWith(color: AppColors.neutral_04)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_controller.singleContract?.cOPENDATE ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(_controller.singleContract?.cEXPIREDATE ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              )
            ]),
          ),
          const SizedBox(height: 24),
          RowInfomation(
              leftText: 'Mã tích lũy',
              rightText: _controller.singleContract?.cCONTRACTCODE ?? ''),
          RowInfomation(
              leftText: 'Kỳ hạn',
              rightText: _controller.singleContract?.cTERMNAME ?? ''),
          RowInfomation(
              leftText: 'Số ngày gửi',
              rightText:
                  "${NumUtils.formatInteger(_controller.singleContract?.cCURRENTDAY)} ngày"),
          RowInfomation(leftText: 'Ngày bắt đầu ', rightText: getToDay()),
          RowInfomation(
              leftText:
                  'Lãi tất toán trước hạn (${_controller.singleContract?.cLIQUIDRATE}%/năm)',
              rightText:
                  '${NumUtils.formatDouble(_controller.singleContract?.cLIQUIDFEE)}đ'),
          RowInfomation(
              leftText: 'Thực nhận',
              rightText: "${NumUtils.formatDouble(sum)}đ"),
        ],
      ),
    );
  }
}
