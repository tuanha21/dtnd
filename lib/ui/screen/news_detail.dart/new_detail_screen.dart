import 'package:dtnd/=models=/response/news_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({super.key, required this.newsModel});
  final NewsModel newsModel;

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final INetworkService networkService = NetworkService();
  final _controller = ScrollController();
  late String newsDetail;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getDetail();
  }

  Future<void> getDetail() async {
    setState(() {
      loading = true;
    });

    newsDetail =
        await networkService.getNewsContent(widget.newsModel.articleID!);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (loading) {
      body = const Center(child: CircularProgressIndicator());
    } else {
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
              HtmlWidget(
                newsDetail.trim(),
                textStyle: AppTextStyle.bodySmall_12,
                onTapUrl: (url) async {
                  // await launchUrl(Uri.parse(url),
                  //     mode: LaunchMode.externalApplication);
                  return true;
                },
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.maxFinite,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HtmlWidget(
                      newsDetail.trim(),
                      textStyle: AppTextStyle.bodySmall_12,
                      onErrorBuilder: (context, element, error) => Container(),
                      onTapUrl: (url) async {
                        // await launchUrl(Uri.parse(url),
                        //     mode: LaunchMode.externalApplication);
                        return true;
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ]),
      );
    }
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        extendBodyBehindAppBar: true,
        body: body);
  }
}
