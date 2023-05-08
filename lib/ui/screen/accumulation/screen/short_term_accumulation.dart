import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/widget/accumulator_header.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';

class ShortTermAccumulation extends StatelessWidget {
  const ShortTermAccumulation({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).short_term_accumulation,
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
                  Text('Tích luỹ 1 tháng', style: textTheme.bodyLarge),
                  const Spacer(),
                  Text('5.5%/năm',
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
                        children: const [
                          RowInfomation(
                              leftText: 'Lãi suất', rightText: '5.5%/năm'),
                          RowInfomation(
                              leftText: 'Kỳ hạn', rightText: '1 tháng'),
                          RowInfomation(
                              leftText: 'Hạn mức tối thiểu',
                              rightText: '1,000,000'),
                          RowInfomation(
                              leftText: 'Hạn mức tối đa',
                              rightText: 'Không giới hạn'),
                          RowInfomation(
                              leftText: 'Lãi suất trước hạn',
                              rightText: '1.2%'),
                          RowInfomation(
                              leftText: 'Phương thức gia hạn',
                              rightText: 'Linh hoạt'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 26),
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
            onPressed: () {},
            child: const Text('Đăng ký'),
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

class RowInfomation extends StatelessWidget {
  const RowInfomation({
    super.key,
    required this.leftText,
    required this.rightText,
  });

  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: textTheme.bodyMedium?.copyWith(color: AppColors.neutral_02),
          ),
          Text(rightText,
              style:
                  textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
