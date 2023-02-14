import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/ui/screen/home/widget/home_section.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    introduce =
        networkService.getCompanyIntroduction(widget.stockCode.stockData.sym);
    super.initState();
  }

  bool isReadMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      // if (document.body?.text.isEmpty == true) {
                      //   return const SizedBox();
                      // }
                      // final span = TextSpan(
                      //     text: document.body?.text.trim(),
                      //     style: Theme.of(context).textTheme.bodySmall);
                      // final tp = TextPainter(
                      //     text: span, textDirection: TextDirection.ltr);
                      // tp.layout(maxWidth: ctx.maxWidth);
                      // final numLines = tp.computeLineMetrics().length;
                      // if (numLines > 6 && isReadMore == false)
                      {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              document.body?.text.trim() ?? "",
                              style: Theme.of(context).textTheme.bodySmall,
                              //maxLines: 6,
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   isReadMore = !isReadMore;
                                // });
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
                              setState(() {
                                isReadMore = !isReadMore;
                              });
                            },
                            child: Text(
                              'Thu gọn',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.primary_01),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                );
              }
              return const SizedBox();
            }),
      ],
    );
  }
}
