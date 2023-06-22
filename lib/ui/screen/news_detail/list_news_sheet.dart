import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
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
  final INetworkService networkService = NetworkService();
  final ScrollController _scrollController = ScrollController();
  List<NewsModel>? listNews;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
    getNews();
  }

  Future<void> getNews({int? recordPerPage}) async {
    listNews = await dataCenterService.getNews(1, recordPerPage ?? 15);
    setState(() {});
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      getNews(recordPerPage: listNews!.length + 5);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget list;
    if (listNews?.isEmpty ?? true) {
      list = Container();
    } else {
      list = ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(
                        dataFunct: networkService.getNewsDetail,
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(
                          newsModel: NewsModel(
                              title: listNews!.elementAt(index).title,
                              articleID: listNews!.elementAt(index).articleID,
                              headImg: listNews!.elementAt(index).headImg,
                              publishTime:
                                  listNews!.elementAt(index).publishTime),
                          dataFunct: networkService.getNewsDetail,
                        ),
                      ))
                      .then((value) => dataCenterService.getNews(1, 15));
                },
                child: HomeNewsCard(
                  stockNews: listNews!.elementAt(index),
                  dataFunct: networkService.getNewsDetail,
                ));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: listNews!.length);
    }
    return SafeArea(
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
    );
  }
}
