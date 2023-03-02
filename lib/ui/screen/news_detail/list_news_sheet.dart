import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/widget/home_news.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';

import 'new_detail_screen.dart';

class ListNewsSheet extends StatefulWidget {
  const ListNewsSheet({super.key});

  @override
  State<ListNewsSheet> createState() => _ListNewsSheetState();
}

class _ListNewsSheetState extends State<ListNewsSheet> {
  final IDataCenterService dataCenterService = DataCenterService();

  List<NewsModel>? listNews;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    listNews = await dataCenterService.getNews(1, 15);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = AppService.instance.themeMode.value;
    Widget list;
    if (listNews?.isEmpty ?? true) {
      list = Container();
    } else {
      list = ListView.separated(
          controller: ScrollController(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(
                        newsModel: NewsModel(
                            title: listNews!.elementAt(index).title,
                            articleID: listNews!.elementAt(index).articleID,
                            headImg: listNews!.elementAt(index).headImg,
                            publishTime:
                                listNews!.elementAt(index).publishTime)),
                  ));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: listNews!.elementAt(index).headImg!,
                      imageBuilder:
                          (BuildContext context, ImageProvider imageProvider) {
                        return Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill)),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(listNews!.elementAt(index).title ?? "",
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 10),
                    Text(listNews!.elementAt(index).title ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.neutral_03)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(listNews!.elementAt(index).publishTime ?? "",
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    )
                  ],
                ),
              );
            }
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(
                        newsModel: NewsModel(
                            title: listNews!.elementAt(index).title,
                            articleID: listNews!.elementAt(index).articleID,
                            headImg: listNews!.elementAt(index).headImg,
                            publishTime:
                                listNews!.elementAt(index).publishTime)),
                  ));
                },
                child: HomeNewsCard(stockNews: listNews!.elementAt(index)));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: listNews!.length);
    }
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SheetHeader(
                implementBackButton: false,
                title: S.of(context).news,
              ),
              const SizedBox(height: 20),
              Expanded(child: list),
            ],
          ),
        ),
      ),
    );
  }
}
