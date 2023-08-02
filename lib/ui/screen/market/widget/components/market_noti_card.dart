import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MarketNotiCard extends StatelessWidget {
  const MarketNotiCard({
    super.key,
    required this.title,
    this.onTap,
    required this.date,
  });

  final String title;
  final DateTime date;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Ink(
          padding: const EdgeInsets.all(8.0),
          height: 88.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.transparent,
          ),
          child: Row(
            children: [
              const SizedBox.square(
                dimension: 75,
                child: Icon(Icons.notifications),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Builder(builder: (context) {
                            final DateFormat format =
                                DateFormat("dd/MM/yyyy HH:mm:ss");

                            return Text(
                              format.format(date),
                              // textAlign: TextAlign.end,
                              style: AppTextStyle.bottomNavLabel
                                  .copyWith(color: AppColors.neutral_03),
                            );
                          }),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          S.of(context).event,
                          style: AppTextStyle.bottomNavLabel
                              .copyWith(color: AppColors.primary_01),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.semantic_02),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: themeData.colorScheme.background,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(56))),
                              child: Row(
                                children: [
                                  SizedBox.square(
                                      dimension: 10,
                                      child: Image.asset(
                                          AppImages.home_icon_like)),
                                  const SizedBox(width: 2),
                                  Text(
                                    "0",
                                    style: AppTextStyle.labelSmall_10,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: themeData.colorScheme.background,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(56))),
                              child: Row(
                                children: [
                                  SizedBox.square(
                                      dimension: 10,
                                      child: Image.asset(
                                          AppImages.home_icon_sharing)),
                                  const SizedBox(width: 2),
                                  Text(
                                    "0",
                                    style: AppTextStyle.labelSmall_10,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ))

                        // const SizedBox(width: 5),
                        // Text(stockNews.stockCode ?? "",
                        //     style: AppTextStyle.labelSmall_10
                        //         .copyWith(fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
