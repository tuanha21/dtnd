import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../=models=/response/company_info.dart';
import '../../../../data/i_network_service.dart';
import '../../../../data/implementations/network_service.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/app_color.dart';
import '../../../widget/icon/stock_icon.dart';
import '../../home/widget/home_section.dart';
import '../widget/index_widget.dart';
import '../widget/introduct_widget.dart';
import '../widget/stock_detail_chart.dart';
import '../widget/stock_detail_news.dart';
import '../widget/stock_event.dart';

class OverviewTab extends StatefulWidget {
  const OverviewTab({
    super.key,
    required this.stockModel,
  });

  final StockModel stockModel;

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StockDetailChart(stockModel: widget.stockModel),
            )),
        const SizedBox(height: 16),
        BasicIndex(stockModel: widget.stockModel),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IntrinsicHeight(
            child: Row(
              children: [
                StockIcon(stockCode: widget.stockModel.stockData.sym),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
              stockModel: widget.stockModel,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class BasicIndex extends StatefulWidget {
  final StockModel stockModel;

  const BasicIndex({Key? key, required this.stockModel}) : super(key: key);

  @override
  State<BasicIndex> createState() => _BasicIndexState();
}

class _BasicIndexState extends State<BasicIndex> {
  Widget indexPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
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
            children: [
              Expanded(
                  child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.neutral_06,
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.prefix_down_icon,
                            height: 20, width: 20),
                        const SizedBox(width: 4),
                        Text(
                          'Giá thấp nhất',
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.stockModel.stockData.lowPrice.value?.toString() ??
                        "",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              )),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.neutral_06,
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.prefix_up_icon,
                            height: 20, width: 20),
                        const SizedBox(width: 4),
                        Text(
                          'Giá cao nhất',
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.stockModel.stockData.highPrice.value?.toString() ??
                        "",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              )),
            ],
          )
        ],
      ),
    );
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class CompanyInfoWidget extends StatefulWidget {
  final StockModel stockModel;

  const CompanyInfoWidget({Key? key, required this.stockModel}) : super(key: key);

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
                children: [
                  Row(
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
                  const SizedBox(height: 16),
                  Row(
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
                          style: textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
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
                          style: textTheme.titleSmall,
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
