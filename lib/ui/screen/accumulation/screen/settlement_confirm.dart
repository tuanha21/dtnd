import 'package:dtnd/ui/screen/accumulation/widget/settlement_success_dialog.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';
import '../widget/row_information.dart';

class SettlementConfirm extends StatefulWidget {
  const SettlementConfirm({
    super.key,
  });

  @override
  State<SettlementConfirm> createState() => _SettlementConfirmState();
}

class _SettlementConfirmState extends State<SettlementConfirm> {
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
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => const SettlementSuccessDialog());
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
          Text('10,000,000đ',
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
                children: const [
                  Text('05/05/2023',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('04/06/2023',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              )
            ]),
          ),
          const SizedBox(height: 24),
          RowInfomation(
              leftText: 'Mã tích lũy', rightText: '04FC711301F3C784D6695'),
          RowInfomation(leftText: 'Sản phẩm', rightText: 'Tích lũy ngắn hạn'),
          RowInfomation(leftText: 'Kỳ hạn', rightText: '1 tháng'),
          RowInfomation(leftText: 'Số ngày gửi', rightText: '21 ngày'),
          RowInfomation(leftText: 'Ngày bắt đầu ', rightText: '05/05/2023'),
          RowInfomation(
              leftText: 'Lãi tất toán trước hạn (1.2%/năm)',
              rightText: '6,904đ'),
          RowInfomation(leftText: 'Thực nhận', rightText: '10,006,904đ'),
        ],
      ),
    );
  }
}
