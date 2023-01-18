import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class SubsidiariesInfoTab extends StatelessWidget {
  const SubsidiariesInfoTab({
    super.key,
    required this.stockModel,
  });
  final StockModel stockModel;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          children: [
            Text(
              "Công ty con",
              style:
                  textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        for (int i = 0; i < stockModel.subsidiaries.subsidiaries!.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: AppColors.neutral_06,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      stockModel.subsidiaries.subsidiaries
                              ?.elementAt(i)
                              .relatedCompanyName ??
                          "-",
                      style: textTheme.labelMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: (stockModel.subsidiaries.subsidiaries
                                        ?.elementAt(i)
                                        .charterCapital ??
                                    0)
                                .toDouble() *
                            2,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            color: AppColors.graphColors.elementAt(i)),
                      ),
                      Text(
                        "${stockModel.subsidiaries.subsidiaries?.elementAt(i).ownerShip?.toString() ?? "-"}%",
                        style: textTheme.labelMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
      ],
    );
  }
}
