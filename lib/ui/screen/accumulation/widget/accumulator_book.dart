import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/controller/accumulation_controller.dart';
import 'package:dtnd/ui/screen/accumulation/screen/accumulator_book_detail.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/service/app_services.dart';

class AccumulatorBook extends StatefulWidget {
  const AccumulatorBook({super.key});

  @override
  State<AccumulatorBook> createState() => _AccumulatorBookState();
}

class _AccumulatorBookState extends State<AccumulatorBook> {
  final AccumulationController controller = AccumulationController();

  String getTitle(String termCode) {
    switch (termCode) {
      case '30':
        return 'Tích lũy ngắn hạn';
      case '90':
        return 'Tích lũy trung hạn';
      case '180':
        return 'Tích lũy dài hạn';
      default:
        return 'Sản phẩm tích lũy tự động';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ObxValue<Rx<bool>>((initialized) {
          if (!initialized.value || controller.listAllContract.value!.isEmpty) {
            return const EmptyListWidget();
          } else {
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(' ${S.of(context).accumulate_current_packages}',
                      style: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.listAllContract.value!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemBuilder(
                          title: getTitle(controller
                              .listAllContract.value![index].termCode
                              .toString()),
                          textTheme: textTheme,
                          dateEnd: controller
                              .listAllContract.value![index].expiredDate
                              .toString(),
                          rate: controller.listAllContract.value![index].feeRate
                              .toString(),
                          id: controller.listAllContract.value![index].id
                              .toString(),
                          profit: controller.listAllContract.value![index].fee
                              .toString(),
                          money: controller
                              .listAllContract.value![index].capital
                              .toString(),
                          controller: controller,
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
        }, controller.accumulationInitialized),
      ],
    );
  }
}

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    super.key,
    required this.title,
    required this.textTheme,
    required this.dateEnd,
    required this.rate,
    required this.id,
    required this.profit,
    required this.money,
    required this.controller,
  });

  final String title;
  final TextTheme textTheme;
  final String dateEnd;
  final String rate;
  final String profit;
  final String money;
  final String id;
  final AccumulationController controller;

  void _onTap(
    BuildContext context,
    String name,
    String id,
  ) {
    // phần này click vào detail các item
    controller.getSingleContract(id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccumulatorBookDetail(
          name: name,
          id: id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final themeMode = AppService.instance.themeMode.value;

    return Container(
      decoration: BoxDecoration(
        color:
            themeMode.isLight ? AppColors.neutral_07 : AppColors.text_black_1,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      height: 150,
      child: Column(children: [
        GestureDetector(
          onTap: () {
            _onTap(context, title, id);
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
                  title,
                  style: textTheme.bodySmall
                      ?.copyWith(color: AppColors.neutral_03),
                ),
                const SizedBox(height: 4),
                Text(
                  '${NumUtils.formatIntegerString(money)}đ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              child: Icon(
                Icons.chevron_right,
                color: themeData.colorScheme.onBackground,
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
            color: themeMode.isLight
                ? AppColors.neutral_07
                : AppColors.bg_share_inside_nav,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$rate%/năm',
                  style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeMode.isLight
                          ? AppColors.neutral_02
                          : AppColors.neutral_07)),
              Text('+${NumUtils.formatDoubleString(profit)}đ',
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
            Text(dateEnd,
                style:
                    textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
          ],
        )
      ]),
    );
  }
}
