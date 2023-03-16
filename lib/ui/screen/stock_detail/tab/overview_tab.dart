import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/sec_event.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../=models=/response/company_info.dart';
import '../../../../=models=/response/news_model.dart';
import '../../../../=models=/response/stock_news.dart';
import '../../../../=models=/response/stock_trading_history.dart';
import '../../../../data/i_network_service.dart';
import '../../../../data/implementations/network_service.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/app_color.dart';
import '../../../widget/news_card.dart';
import '../../home/widget/home_section.dart';
import '../../news_detail/new_detail_screen.dart';
import '../widget/index_widget.dart';
import '../widget/introduct_widget.dart';
import '../widget/stock_detail_chart.dart';
import '../widget/stock_detail_news.dart';
import '../widget/stock_event.dart';
import 'dart:math' as math;

class OverviewTab extends StatefulWidget {
  const OverviewTab({
    super.key,
    required this.stockModel,
  });

  final StockModel stockModel;

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab>
    with AutomaticKeepAliveClientMixin {
  final IDataCenterService dataCenterService = DataCenterService();

  List<SecEvent>? listEvent;
  @override
  void initState() {
    super.initState();
    getEvent();
  }

  void getEvent() async {
    listEvent =
        await dataCenterService.getListEvent(widget.stockModel.stockData.sym);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        StockDetailChart(stockModel: widget.stockModel),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IntrinsicHeight(
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://info.sbsi.vn/logo/${widget.stockModel.stock.stockCode}',
                  imageBuilder: (context, provider) {
                    return Container(
                      height: 63,
                      width: 63,
                      decoration: BoxDecoration(
                          color: AppColors.neutral_06,
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                              image: provider, fit: BoxFit.contain)),
                    );
                  },
                  errorWidget: (context, _, __) {
                    return Container(
                      height: 63,
                      width: 63,
                      decoration: BoxDecoration(
                          color: AppColors.neutral_06,
                          borderRadius: BorderRadius.circular(4)),
                    );
                  },
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(widget.stockModel.stock.stockCode,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.stockModel.stock.postTo!.name} : ${widget.stockModel.stock.nameShort}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.neutral_04),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        CompanyInfoWidget(stockModel: widget.stockModel),
        const SizedBox(height: 16),
        IntroduceWidget(stockCode: widget.stockModel),
        const SizedBox(height: 16),
        HomeSection(
          title: S.of(context).news,
          onMore: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12))),
                builder: (context) {
                  return ListNewsISheet(model: widget.stockModel);
                });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                StockDetailNews(stockCode: widget.stockModel.stock.stockCode),
          ),
        ),
        const SizedBox(height: 20),
        HomeSection(
          title: S.of(context).event,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StockEvent(
              listEvent: listEvent,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BasicIndex extends StatefulWidget {
  final StockModel stockModel;
  final StockTradingHistory history;

  const BasicIndex({Key? key, required this.stockModel, required this.history})
      : super(key: key);

  @override
  State<BasicIndex> createState() => _BasicIndexState();
}

class _BasicIndexState extends State<BasicIndex> {
  Widget indexPrice() {
    var data = widget.history;
    var max = data.h.reduce(math.max);
    var min = data.l.reduce(math.min);

    // print('max: ' + max.toString());
    // print('min: ' + min.toString());
    // print(
    //     'lastPrice: ' + widget.stockModel.stockData.lastPrice.value.toString());

    return Column(
      children: [
        Row(
          children: [
            Text(
              "Chỉ số cơ bản",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 6),
            SvgPicture.asset(AppImages.circleAlert)
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Giá thấp nhất"),
            Text("Giá cao nhất"),
          ],
        ),
        const SizedBox(height: 5),
        PercentPrice(
          min: min,
          max: max,
          lastPrice: widget.stockModel.stockData.lastPrice.value!,
        )
      ],
    );
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.light_bg, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          indexPrice(),
          ExpandedSection(
              expand: isExpanded,
              child: IndexWidget(stockModel: widget.stockModel)),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary_04,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                !isExpanded ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                color: AppColors.light_bg,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PercentPrice extends StatelessWidget {
  final num min;
  final num max;
  final num lastPrice;

  const PercentPrice(
      {Key? key, required this.min, required this.max, required this.lastPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          min.toString(),
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: LayoutBuilder(builder: (context, ctx) {
            var length = max - min;

            var _lastPrice = lastPrice > max
                ? max
                : lastPrice < min
                    ? min
                    : lastPrice;

            var percent = (_lastPrice - min) / length * 100;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 3),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 10,
                    child: Row(
                      children: [
                        Container(
                          width: ctx.maxWidth * percent / 100,
                          decoration:
                              const BoxDecoration(color: AppColors.neutral_03),
                        ),
                        Container(
                          width: ctx.maxWidth * (100 - percent) / 100,
                          decoration:
                              const BoxDecoration(color: AppColors.neutral_02),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Padding(
                  padding:
                      EdgeInsets.only(left: ctx.maxWidth * percent / 100 - 7.5),
                  child: CustomPaint(
                      size: const Size(15, 15), painter: DrawTriangleShape()),
                )
              ],
            );
          }),
        ),
        const SizedBox(width: 10),
        Text(
          max.toString(),
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}

class DrawTriangleShape extends CustomPainter {
  late Paint painter;

  DrawTriangleShape() {
    painter = Paint()
      ..color = AppColors.neutral_03
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CompanyInfoWidget extends StatefulWidget {
  final StockModel stockModel;

  const CompanyInfoWidget({Key? key, required this.stockModel})
      : super(key: key);

  @override
  State<CompanyInfoWidget> createState() => _CompanyInfoWidgetState();
}

class _CompanyInfoWidgetState extends State<CompanyInfoWidget> {
  late Future<CompanyInfo> companyInfo;
  final INetworkService iNetworkService = NetworkService();

  @override
  void initState() {
    companyInfo =
        iNetworkService.getCompanyInfo(widget.stockModel.stockData.sym);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder<CompanyInfo>(
        future: companyInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            var info = snapshot.data!;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: AppColors.neutral_06,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ngày thành lập",
                              style: textTheme.bodyMedium!
                                  .copyWith(color: AppColors.neutral_03),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              info.foundDateString,
                              style: textTheme.titleSmall,
                            ),
                          ],
                        )),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mã số thuế",
                              style: textTheme.bodyMedium!
                                  .copyWith(color: AppColors.neutral_03),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              info.taxCode ?? "",
                              style: textTheme.titleSmall,
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tên viết tắt",
                              style: textTheme.bodyMedium!
                                  .copyWith(color: AppColors.neutral_03),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              info.name ?? "",
                              style: textTheme.titleSmall,
                            ),
                          ],
                        )),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Người đại diện",
                              style: textTheme.bodyMedium!
                                  .copyWith(color: AppColors.neutral_03),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              info.infoSupplier ?? "",
                              style: textTheme.titleSmall,
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () async {
                      var canLunch = await canLaunchUrl(
                          Uri(scheme: 'tel', path: info.phone ?? ""));
                      if (canLunch) {
                        launchUrl(Uri(scheme: 'tel', path: info.phone ?? ""));
                      }
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.call,
                          width: 15,
                        ),
                        const SizedBox(width: 9),
                        Text(
                          info.phone ?? "",
                          style: textTheme.titleSmall
                              ?.copyWith(color: AppColors.primary_01),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      var canLunch =
                          await canLaunchUrl(Uri.parse(info.uRL ?? ""));
                      if (canLunch) {
                        launchUrl(Uri.parse(info.uRL ?? ""));
                      }
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.global,
                          width: 15,
                        ),
                        const SizedBox(width: 9),
                        Text(
                          info.uRL ?? "",
                          style: textTheme.titleSmall
                              ?.copyWith(color: AppColors.primary_01),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return const SizedBox();
        });
  }
}

class ListNewsISheet extends StatefulWidget {
  final StockModel model;

  const ListNewsISheet({Key? key, required this.model}) : super(key: key);

  @override
  State<ListNewsISheet> createState() => _ListNewsISheetState();
}

class _ListNewsISheetState extends State<ListNewsISheet> {
  final INetworkService networkService = NetworkService();

  late Future<List<StockNews>> stockNews;

  @override
  void initState() {
    stockNews = networkService.getStockNews(widget.model.stockData.sym);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).news,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: AppColors.primary_03,
                      borderRadius: BorderRadius.circular(6)),
                  child: const Icon(
                    Icons.clear,
                    color: AppColors.text_black_1,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
          const Divider(
            height: 36,
            color: AppColors.light_tabBar_bg,
            thickness: 1,
          ),
          Expanded(
            child: FutureBuilder<List<StockNews>>(
                future: stockNews,
                initialData: const [],
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var listNews = snapshot.data!;
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NewsDetailScreen(
                                      newsModel: NewsModel(
                                          title: listNews[index].title,
                                          articleID: listNews[index].articleID,
                                          headImg: listNews[index].imageUrl,
                                          publishTime:
                                              listNews[index].publishTime)),
                                ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: listNews[index].imageUrl!,
                                    imageBuilder: (BuildContext context,
                                        ImageProvider imageProvider) {
                                      return Container(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fill)),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Text(listNews[index].title ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  const SizedBox(height: 10),
                                  Text(listNews[index].head ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: AppColors.neutral_03)),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(listNews[index].source ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700)),
                                      Text(
                                          DateFormat("dd/MM/yyyy").format(
                                              listNews[index].dateTime!),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
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
                                          title: listNews[index].title,
                                          articleID: listNews[index].articleID,
                                          headImg: listNews[index].imageUrl,
                                          publishTime:
                                              listNews[index].publishTime)),
                                ));
                              },
                              child: NewsCard(stockNews: listNews[index]));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        itemCount: listNews.length);
                  }
                  return const SizedBox();
                }),
          ),
        ],
      ),
    );
  }
}
