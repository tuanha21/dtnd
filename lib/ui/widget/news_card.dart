import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/stock_news.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.stockNews,
  });
  final StockNews stockNews;
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    return Material(
      child: InkWell(
        onTap: () {},
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Ink(
          padding: const EdgeInsets.all(8.0),
          height: 88.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color:
                themeMode.isDark ? AppColors.neutral_01 : AppColors.neutral_06,
          ),
          child: Row(
            children: [
              SizedBox.square(
                dimension: 75,
                child: Hero(
                  tag: stockNews.articleID,
                  child: CachedNetworkImage(
                    imageUrl: stockNews.imageUrl ??
                        "https://via.placeholder.com/75x75",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        stockNews.title ?? "Title",
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
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
        ),
      ),
    );
  }
}
