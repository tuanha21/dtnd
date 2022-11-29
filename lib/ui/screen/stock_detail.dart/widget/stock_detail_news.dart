import 'package:dtnd/=models=/response/stock_news.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/widget/news_card.dart';
import 'package:flutter/material.dart';

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

  bool initialized = false;
  @override
  void initState() {
    getStockNews();
    super.initState();
  }

  void getStockNews() async {
    stockNews = await networkService.getStockNews(widget.stockCode);
    setState(() {
      initialized = true;
    });
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
    return Column(
      children: [
        for (final StockNews news in stockNews)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: NewsCard(stockNews: news),
          )
      ],
    );
  }
}
