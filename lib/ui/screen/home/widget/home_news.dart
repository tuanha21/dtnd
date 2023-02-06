import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/ui/screen/home/home_controller.dart';
import 'package:dtnd/ui/screen/news_detail.dart/new_detail_screen.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({super.key});

  @override
  State<HomeNews> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  final HomeController controller = HomeController();
  @override
  void initState() {
    super.initState();
    controller.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.newsLoading.value) {
          return Center(
            child: SizedBox(height: 520, child: Text(S.of(context).loading)),
          );
        } else {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              children: [
                for (int i = 0; i < controller.news.length; i++)
                  if (i != 0)
                    Column(
                      children: [
                        const Divider(),
                        HomeNewsCard(
                          stockNews: controller.news.elementAt(i),
                        )
                      ],
                    )
                  else
                    HomeNewsCard(
                      stockNews: controller.news.elementAt(i),
                    )
              ],
            ),
          );
        }
      },
    );
  }
}

class HomeNewsCard extends StatelessWidget {
  const HomeNewsCard({
    super.key,
    required this.stockNews,
  });
  final NewsModel stockNews;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewsDetailScreen(newsModel: stockNews),
          ));
        },
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
              SizedBox.square(
                dimension: 75,
                child: Hero(
                  tag: stockNews.articleID!,
                  child: CachedNetworkImage(
                    imageUrl: stockNews.headImg ??
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
                        textAlign: TextAlign.left,
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
                        Expanded(
                          child: Text(
                            stockNews.publishTime ?? "",
                            textAlign: TextAlign.end,
                            style: AppTextStyle.bottomNavLabel,
                          ),
                        )
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
