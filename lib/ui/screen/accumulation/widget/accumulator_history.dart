import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/calendar/day_input.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';

class AccumulatorHistory extends StatefulWidget {
  const AccumulatorHistory({super.key});

  @override
  State<AccumulatorHistory> createState() => _AccumulatorHistoryState();
}

class _AccumulatorHistoryState extends State<AccumulatorHistory> {
  late DateTime fromDay;
  late DateTime toDay;
  late DateTime firstDay;
  late DateTime lastDay;

  final List<String> title = <String>[
    'Tích lũy ngắn hạn',
    'Tích lũy ngắn hạn',
    'Tích lũy tự động'
  ];
  final List<String> moneyChange = <String>[
    '+10,000,000đ',
    '-10,006,904đ',
    '+1,763,050đ'
  ];

  @override
  void initState() {
    fromDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(1));
    toDay = DateTime.now();
    firstDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(3));
    lastDay = toDay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: DayInput(
                color: Colors.white,
                initialDay: fromDay,
                firstDay: firstDay,
                lastDay: lastDay,
                onChanged: (value) {
                  setState(() {
                    fromDay = value;
                  });
                },
              ),
            ),
            const Text("    -    "),
            Expanded(
              flex: 1,
              child: DayInput(
                color: Colors.white,
                initialDay: toDay,
                firstDay: firstDay,
                lastDay: lastDay,
                onChanged: (value) {
                  setState(() {
                    toDay = value;
                  });
                },
              ),
            )
          ],
        ),
      ),
      const SizedBox(height: 20),
      Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: title.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                height: 70,
                child: Row(children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      (index.isEven)
                          ? AppImages.settlement_plus
                          : AppImages.settlement_minus,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title[index],
                          style: textTheme.bodyMedium
                              ?.copyWith(color: AppColors.text_black),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '01/11/2022',
                              style: textTheme.bodySmall
                                  ?.copyWith(color: AppColors.neutral_02),
                            ),
                            const Spacer(),
                            Text(
                              moneyChange[index],
                              style: textTheme.bodyMedium?.copyWith(
                                  color: index.isEven
                                      ? AppColors.semantic_04_1
                                      : AppColors.semantic_03),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ]),
              );
            }),
      )
    ]);
  }
}
