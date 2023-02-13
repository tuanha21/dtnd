import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../=models=/response/introduct_company.dart';
import '../../../../data/i_network_service.dart';
import '../../../../data/implementations/network_service.dart';
import '../../../theme/app_color.dart';
import '../../home/widget/home_section.dart';

class IntroduceWidget extends StatefulWidget {
  final String stockCode;

  const IntroduceWidget({Key? key, required this.stockCode}) : super(key: key);

  @override
  State<IntroduceWidget> createState() => _IntroduceWidgetState();
}

class _IntroduceWidgetState extends State<IntroduceWidget> {
  final INetworkService networkService = NetworkService();

  late Future<CompanyIntroductionResponse> introduce;

  @override
  void initState() {
    introduce = networkService.getCompanyIntroduction(widget.stockCode);
    super.initState();
  }

  bool isReadMore = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CompanyIntroductionResponse>(
        future: introduce,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            var profile = snapshot.data?.data?.profile;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Giới thiệu",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  HtmlWidget(
                    profile.toString(),
                    onErrorBuilder: (context, element, error) => Container(),
                    onTapUrl: (url) async {
                      return true;
                    },
                    customWidgetBuilder: (element) {
                      return LayoutBuilder(builder: (context, ctx) {
                        // final span = TextSpan(
                        //     text: element.text,
                        //     style: Theme.of(context).textTheme.bodySmall);
                        // final tp = TextPainter(
                        //     text: span, textDirection: TextDirection.ltr);
                        // tp.layout(maxWidth: ctx.maxWidth);
                        // final numLines = tp.computeLineMetrics().length;
                        // if (numLines > 6 && isReadMore == false) {
                        //   return Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         element.text,
                        //         style: Theme.of(context).textTheme.bodySmall,
                        //         maxLines: 6,
                        //       ),
                        //       const SizedBox(height: 10),
                        //       GestureDetector(
                        //         onTap: () {
                        //           setState(() {
                        //             isReadMore = !isReadMore;
                        //           });
                        //         },
                        //         child: Text(
                        //           'Xem thêm',
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .bodySmall
                        //               ?.copyWith(color: AppColors.primary_01),
                        //         ),
                        //       ),
                        //       const SizedBox(height: 16),
                        //     ],
                        //   );
                        // }
                        return Text(
                          element.text,
                          style: Theme.of(context).textTheme.bodySmall,
                        );
                      });
                    },
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        });
  }
}
