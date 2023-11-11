import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/market/stock_news.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/service/app_services.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.stockNews,
  });

  final StockNews stockNews;

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox.square(
            dimension: 60,
            child: Hero(
              tag: stockNews.articleID,
              child: CachedNetworkImage(
                imageUrl:
                    stockNews.imageUrl ?? "https://via.placeholder.com/75x75",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    image:
                        DecorationImage(image: imageProvider, fit: BoxFit.fill),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    stockNews.title ?? "Title",
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: themeMode.isLight ? null : AppColors.neutral_07),
                  ),
                ),
                Text(DateFormat("dd/MM/yyyy").format(stockNews.dateTime!),
                    style: AppTextStyle.labelSmall_10.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.neutral_03)),
                Row(
                  children: [
                    Text(
                      S.of(context).news,
                      style: AppTextStyle.bottomNavLabel
                          .copyWith(color: AppColors.primary_01),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.semantic_02),
                    ),
                    const SizedBox(width: 5),
                    Text(stockNews.stockCode ?? "",
                        style: AppTextStyle.labelSmall_10
                            .copyWith(fontWeight: FontWeight.w400)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
