import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/=models=/response/stock_news.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/news_card.dart';
import 'package:flutter/material.dart';

import '../../news_detail/new_detail_screen.dart';

class StockDetailNews extends StatefulWidget {
  const StockDetailNews({
    super.key,
    required this.stockCode,
  });

  final String stockCode;

  @override
  State<StockDetailNews> createState() => _StockDetailNewsState();
}

class _StockDetailNewsState extends State<StockDetailNews> {
  final INetworkService networkService = NetworkService();
  late final List<StockNews> stockNews;
  late final List<StockNews> shortStockNews;

  bool initialized = false;

  @override
  void initState() {
    getStockNews();
    super.initState();
  }

  void getStockNews() async {
    stockNews = await networkService.getStockNews(widget.stockCode);
    var length = stockNews.length > 3 ? 3 : stockNews.length;
    shortStockNews = stockNews.getRange(0, length).toList();
    if (mounted) {
      setState(() {
        initialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(S.of(context).loading),
        ),
      );
    }
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.neutral_07,
      ),
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(
                        newsModel: NewsModel(
                            title: shortStockNews[index].title,
                            articleID: shortStockNews[index].articleID,
                            headImg: shortStockNews[index].imageUrl,
                            publishTime: shortStockNews[index].publishTime)),
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NewsCard(stockNews: shortStockNews[index]),
                ));
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 2,
              color: AppColors.neutral_06,
              height: 16,
            );
          },
          itemCount: shortStockNews.length),
    );
  }
}
