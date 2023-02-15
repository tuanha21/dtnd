import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/ui/screen/home/widget/home_section.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../=models=/response/company_info.dart';
import '../../../../=models=/response/introduct_company.dart';
import '../../../../data/i_network_service.dart';
import '../../../../data/implementations/network_service.dart';
import 'package:html/parser.dart' show parse;
import '../../../theme/app_color.dart';
import '../sheet/business_infomation_sheet.dart';

class IntroduceWidget extends StatefulWidget {
  final StockModel stockCode;

  const IntroduceWidget({Key? key, required this.stockCode}) : super(key: key);

  @override
  State<IntroduceWidget> createState() => _IntroduceWidgetState();
}

class _IntroduceWidgetState extends State<IntroduceWidget> {
  final INetworkService networkService = NetworkService();

  late Future<CompanyIntroductionResponse> introduce;

  late Future<CompanyInfo> companyInfo;

  @override
  void initState() {
    introduce =
        networkService.getCompanyIntroduction(widget.stockCode.stockData.sym);

    companyInfo = networkService.getCompanyInfo(widget.stockCode.stockData.sym);
    super.initState();
  }

  bool isReadMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<CompanyIntroductionResponse>(
            future: introduce,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                var profile = snapshot.data?.data?.profile;
                var document = parse(profile);
                return HomeSection(
                  title: "Về ${widget.stockCode.stockData.sym}",
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: LayoutBuilder(builder: (context, ctx) {
                      {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              document.body?.text.trim() ?? "",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: false,
                                    context: context,
                                    builder: (context) {
                                      return BusinessInformationSheet(
                                          stockModel: widget.stockCode);
                                    });
                              },
                              child: Text(
                                'Xem thêm',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.primary_01),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                  ),
                );
              }
              return const SizedBox();
            }),
        const SizedBox(height: 16),
        FutureBuilder<CompanyInfo>(
            future: companyInfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                var info = snapshot.data;
                var colorBoder = AppColors.neutral_04;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            height: 28,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: colorBoder)),
                            child: Text(
                              info?.companyTypeName ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            )),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: 28,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: (){
                                canLaunchUrl(Uri.parse(info?.uRL ?? ""));
                              },
                              child: Container(
                                  height: 28,
                                  margin: const EdgeInsets.only(left: 16,right: 5),
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: colorBoder)),
                                  child: Text(
                                    "Website công ty",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  )),
                            ),
                            GestureDetector(
                              onTap: (){
                                canLaunchUrl(Uri(scheme: 'tel',path: info?.phone ?? ""));
                              },
                              child: Container(
                                  height: 28,
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: colorBoder)),
                                  child: Text(
                                    info?.phone ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            })
      ],
    );
  }
}
