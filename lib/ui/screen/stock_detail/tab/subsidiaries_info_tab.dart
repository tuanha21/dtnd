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
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: AppColors.neutral_06,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        stockModel.subsidiaries.subsidiaries?[i]
                                .relatedCompanyName ??
                            "-",
                        style: textTheme.labelMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(child: LayoutBuilder(
                      builder: (context, ctx) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: ctx.maxWidth * stockModel.subsidiaries.subsidiaries![i].ownerShip! / 400,
                              height: 10,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  color: AppColors.graph_2),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${stockModel.subsidiaries.subsidiaries?[i].ownerShip?.toString() ?? "-"}%",
                              style: textTheme.labelMedium!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        );
                      },
                    ))
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemCount: stockModel.subsidiaries.subsidiaries?.length ?? 0)
      ],
    );
  }
}
