import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/stock_news.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
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
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(stockNews.title ?? "Title"),
                    Text(stockNews.stockCode ?? "StockCode"),
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
