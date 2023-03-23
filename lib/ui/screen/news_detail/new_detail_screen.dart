import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen(
      {super.key, required this.newsModel, required this.dataFunct});

  final NewsModel newsModel;
  final Future<String> Function(int id) dataFunct;
  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final INetworkService networkService = NetworkService();
  final _controller = ScrollController();
  late Future<String> newsDetail;

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  void getDetail() {
    newsDetail = widget.dataFunct.call(widget.newsModel.articleID!);
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    body = SingleChildScrollView(
      controller: _controller,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              height: 300,
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.newsModel.headImg ?? ""),
                      fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.black.withOpacity(0.2),
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.newsModel.title}",
                            style: AppTextStyle.headlineSmall_24
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(widget.newsModel.publishTime ?? "",
                              style: AppTextStyle.bodyMedium_14
                                  .copyWith(color: Colors.white))
                        ]),
                  )
                ],
              ),
            ),
            FutureBuilder<String>(
                future: newsDetail,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(snapshot.error?.toString() ?? ""),
                      ));
                    }
                    var data = snapshot.data;
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HtmlWidget(
                            data!,
                            textStyle: AppTextStyle.bodySmall_12,
                            // factoryBuilder: ,
                            onErrorBuilder: (context, element, error) =>
                                Container(),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  }

                  return const SizedBox();
                })
          ]),
    );

    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        extendBodyBehindAppBar: true,
        body: body);
  }
}
