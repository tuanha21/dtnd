import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/home_controller.dart';
import 'package:dtnd/ui/screen/news_detail/new_detail_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../config/service/app_services.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({super.key});

  @override
  State<HomeNews> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  final INetworkService networkService = NetworkService();
  final HomeController controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.getNews();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Obx(
      () {
        if (controller.newsLoading.value) {
          return Center(
            child: SizedBox(height: 520, child: Text(S.of(context).loading)),
          );
        } else {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
                color: themeMode.isLight ? AppColors.neutral_07 : AppColors.bg_share_inside_nav,
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Column(
              children: [
                for (int i = 0; i < controller.news.length; i++)
                  if (i != 0)
                    Column(
                      children: [
                          Divider(
                          color: themeMode.isLight ? AppColors.neutral_07 : AppColors.neutral_03,
                        ),
                        HomeNewsCard(
                          dataFunct: networkService.getNewsDetail,
                          stockNews: controller.news.elementAt(i),
                          onDetail: controller.getNews,
                        )
                      ],
                    )
                  else
                    HomeNewsCard(
                      dataFunct: networkService.getNewsDetail,
                      stockNews: controller.news.elementAt(i),
                      onDetail: controller.getNews,
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
    this.onDetail,
    required this.dataFunct,
  });

  final NewsModel stockNews;
  final Future<String> Function(int id) dataFunct;
  final VoidCallback? onDetail;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final themeMode = AppService.instance.themeMode.value;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(
                      dataFunct: dataFunct, newsModel: stockNews),
                ),
              )
              .then((value) => onDetail?.call());
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            stockNews.title ?? "Title",
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
                            final Duration duration;
                            if (stockNews.publishTime == null) {
                              duration = Duration.zero;
                            } else {
                              duration = DateTime.now().difference(
                                  format.parse(stockNews.publishTime!));
                            }
                            final String ago;
                            if (duration.inHours > 23) {
                              ago = S.of(context).days_ago(duration.inDays);
                            } else if (duration.inHours > 0) {
                              ago = S.of(context).hours_ago(duration.inHours);
                            } else {
                              ago =
                                  S.of(context).minutes_ago(duration.inMinutes);
                            }
                            return Text(
                              ago,
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
                                color: themeMode.isLight ? AppColors.neutral_07 : AppColors.text_grey_1,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(56),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox.square(
                                      dimension: 10,
                                      child: Image.asset(
                                          AppImages.home_icon_like,
                                      color:  AppColors.neutral_07  )),
                                  const SizedBox(width: 2),
                                  Text(
                                    "${stockNews.viewCount}",
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
                                color: themeMode.isLight ? AppColors.neutral_07 : AppColors.text_grey_1,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(56),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox.square(
                                      dimension: 10,
                                      child: Image.asset(
                                          AppImages.home_icon_sharing,
                                      color: themeMode.isDark ? AppColors.neutral_07 : AppColors.text_grey_1,)),
                                  const SizedBox(width: 2),
                                  Text(
                                    "${stockNews.commentCount}",
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
