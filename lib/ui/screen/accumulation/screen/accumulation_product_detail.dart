import 'package:dtnd/=models=/response/accumulation/fee_rate_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/controller/accumulation_controller.dart';
import 'package:dtnd/ui/screen/accumulation/screen/accumulation_register.dart';
import 'package:dtnd/ui/screen/accumulation/widget/accumulator_header.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/row_information.dart';

class AccumulationProductDetail extends StatefulWidget {
  const AccumulationProductDetail({super.key, required this.id});
  final String id;

  @override
  State<AccumulationProductDetail> createState() =>
      _AccumulationProductDetailState();
}

class _AccumulationProductDetailState extends State<AccumulationProductDetail> {
  final AccumulationController _controller = Get.put(AccumulationController());
  late FeeRateModel feeRate = _controller.getItemFeeRate(widget.id);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: SimpleAppbar(
        title: feeRate.productName.toString(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AccumulatorHeader(),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text('Tích luỹ ${feeRate.termName.toString()}',
                      style: textTheme.bodyLarge),
                  const Spacer(),
                  Text('${feeRate.feeRate.toString()}%/năm',
                      style: textTheme.bodyLarge
                          ?.copyWith(color: AppColors.semantic_01)),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.accent_light_04,
                          child: Image.asset(
                            AppImages.light,
                            height: 40,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bạn có thể bắt đầu bất cứ lúc nào 💯',
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.text_blue)),
                            const SizedBox(height: 4),
                            Text('Đăng ký ngay đừng bỏ lỡ',
                                style: textTheme.bodySmall
                                    ?.copyWith(color: AppColors.neutral_03)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 12, left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: AppColors.neutral_06,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          RowInfomation(
                              leftText: S.of(context).profit,
                              rightText: '${feeRate.feeRate.toString()}%/năm'),
                          RowInfomation(
                              leftText: S.of(context).period,
                              rightText: feeRate.termName.toString()),
                          RowInfomation(
                              leftText: S.of(context).minimum_limit,
                              rightText:
                                  NumUtils.formatInteger(feeRate.capMin)),
                          RowInfomation(
                              leftText: S.of(context).maximum_limit,
                              rightText:
                                  NumUtils.formatInteger(feeRate.capMax)),
                          RowInfomation(
                              leftText: S.of(context).early_interest_rate,
                              rightText: feeRate.liquidRate.toString()),
                          RowInfomation(
                              leftText: S.of(context).renewal_method,
                              rightText: 'Linh hoạt'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 26),
              if (feeRate.productName == 'Sản phẩm tích lũy tự động')
                (Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CHÚ THÍCH (*)',
                        style: textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    RowQuote(quote: S.of(context).accumulation_quote1),
                    RowQuote(quote: S.of(context).accumulation_quote2),
                    RowQuote(quote: S.of(context).accumulation_quote3),
                    RowQuote(quote: S.of(context).accumulation_quote4),
                  ],
                )),
              const SizedBox(height: 70),
            ],
          ),
        ),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AccumulationRegister(
                          id: widget.id,
                        )),
              );
            },
            child: Text(S.of(context).sign_up),
          ),
        ),
      ),
    );
  }
}

class RowQuote extends StatelessWidget {
  const RowQuote({
    super.key,
    required this.quote,
  });

  final String quote;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 13,
            width: 9,
            child: Container(
              color: AppColors.text_blue,
              margin: const EdgeInsets.only(top: 4),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(child: Text(quote, style: textTheme.bodySmall)),
        ],
      ),
    );
  }
}
