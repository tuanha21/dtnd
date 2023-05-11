import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/screen/automatic_accumulation.dart';
import 'package:dtnd/ui/screen/accumulation/screen/short_term_accumulation.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

class AccumulatorProduct extends StatefulWidget {
  const AccumulatorProduct({super.key});

  @override
  State<AccumulatorProduct> createState() => _AccumulatorProductState();
}

class _AccumulatorProductState extends State<AccumulatorProduct> {
  final List<String> title = <String>[
    'Tích lũy tự động',
    'Tích lũy ngắn hạn',
    'Tích lũy trung hạn'
  ];
  final List<String> period = <String>['1 tuần', '1 tháng', '3 tháng'];
  final List<String> rate = <String>['3.5 %', '5.5 %', '6.5%'];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(children: [
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: title.length,
          itemBuilder: (BuildContext context, int index) {
            return ItemBuilder(
              title: title,
              textTheme: textTheme,
              period: period,
              rate: rate,
              index: index,
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
    required this.period,
    required this.rate,
    required this.index,
  });

  final List<String> title;
  final TextTheme textTheme;
  final List<String> period;
  final List<String> rate;
  final int index;

  void _onTap(BuildContext context, String name) {
    switch (name) {
      case 'Tích lũy tự động':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AutomaticAccumulation()),
        );
        break;
      case 'Tích lũy ngắn hạn':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ShortTermAccumulation()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      height: 140,
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
            Text(
              title[index],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const SizedBox(
              child: Icon(
                Icons.chevron_right,
                color: Colors.black,
                size: 28.0,
              ),
            )
          ]),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                  color: AppColors.primary_04,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                ),
              ),
            ),
            Flexible(
              flex: 14,
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: AppColors.neutral_06,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).period,
                            style: textTheme.bodySmall
                                ?.copyWith(color: AppColors.neutral_04),
                          ),
                          Text(S.of(context).profit,
                              style: textTheme.bodySmall
                                  ?.copyWith(color: AppColors.neutral_04)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(period[index],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(rate[index],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    ]),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
