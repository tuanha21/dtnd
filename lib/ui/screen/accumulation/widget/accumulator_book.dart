import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/screen/accumulator_book_detail.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

class AccumulatorBook extends StatefulWidget {
  const AccumulatorBook({super.key});

  @override
  State<AccumulatorBook> createState() => _AccumulatorBookState();
}

class _AccumulatorBookState extends State<AccumulatorBook> {
  final List<String> title = <String>[
    'Tích lũy ngắn hạn',
    'Tích lũy tự động',
  ];
  final List<String> dateEnd = <String>['04/06/2023', '16/06/2023'];
  final List<String> rate = <String>[
    '5.5%/năm',
    '3.5%/năm',
  ];
  final List<String> money = <String>[
    '10,000,000đ',
    '12,000,000đ',
  ];

  final List<String> profit = <String>[
    '+45,205đ',
    '+8,054đ',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 16),
      Text(' ${S.of(context).accumulate_current_packages}',
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
      const SizedBox(height: 4),
      Expanded(
        child: ListView.builder(
          itemCount: title.length,
          itemBuilder: (BuildContext context, int index) {
            return ItemBuilder(
              title: title,
              textTheme: textTheme,
              dateEnd: dateEnd,
              rate: rate,
              index: index,
              profit: profit,
              money: money,
            );
          },
        ),
      )
    ]);
  }
}

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    super.key,
    required this.title,
    required this.textTheme,
    required this.dateEnd,
    required this.rate,
    required this.index,
    required this.profit,
    required this.money,
  });

  final List<String> title;
  final TextTheme textTheme;
  final List<String> dateEnd;
  final List<String> rate;
  final List<String> profit;
  final List<String> money;
  final int index;

  void _onTap(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AccumulatorBookDetail(name: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      height: 150,
      child: Column(children: [
        GestureDetector(
          onTap: () {
            _onTap(context, title[index]);
          },
          child: Row(children: [
            CircleAvatar(
              backgroundColor: AppColors.accent_light_04,
              child: Image.asset(
                AppImages.wallet_3,
                height: 40,
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title[index],
                  style: textTheme.bodySmall
                      ?.copyWith(color: AppColors.neutral_02),
                ),
                const SizedBox(height: 4),
                Text(
                  money[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            const SizedBox(
              child: Icon(
                Icons.chevron_right,
                color: AppColors.neutral_01,
                size: 28.0,
              ),
            )
          ]),
        ),
        const SizedBox(height: 12),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.neutral_06,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(rate[index],
                  style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.neutral_02)),
              Text(profit[index],
                  style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.semantic_01)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text('${S.of(context).end_date}: ',
                style:
                    textTheme.bodySmall?.copyWith(color: AppColors.neutral_03)),
            Text(dateEnd[index],
                style:
                    textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
          ],
        )
      ]),
    );
  }
}
