import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/controller/accumulation_controller.dart';
import 'package:dtnd/ui/screen/accumulation/screen/accumulation_product_detail.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccumulatorProduct extends StatefulWidget {
  const AccumulatorProduct({super.key});

  @override
  State<AccumulatorProduct> createState() => _AccumulatorProductState();
}

class _AccumulatorProductState extends State<AccumulatorProduct> {
  final AccumulationController controller = AccumulationController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ObxValue<Rx<bool>>((initialized) {
        if (!initialized.value) {
          return const EmptyListWidget();
        } else {
          if (controller.listFeeRate.value == []) {
            return const EmptyListWidget();
          }
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: controller.listFeeRate.value!.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemBuilder(
                  title: controller.listFeeRate.value![index].productName ?? '',
                  textTheme: textTheme,
                  period: controller.listFeeRate.value![index].termName ?? '',
                  rate: controller.listFeeRate.value![index].feeRate.toString(),
                  id: controller.listFeeRate.value![index].id.toString(),
                );
              },
            ),
          );
        }
      }, controller.accumulationInitialized),
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
    required this.id,
  });

  final String title;
  final TextTheme textTheme;
  final String period;
  final String rate;
  final String id;

  void _onTap(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AccumulationProductDetail(
                id: id,
              )),
    );
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
            _onTap(context, id);
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
              title,
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
                          Text(period,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text('$rate%',
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