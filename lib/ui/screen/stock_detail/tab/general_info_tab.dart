import 'package:dtnd/=models=/response/market/stock_model.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../=models=/response/market/company_info.dart';
import '../../../../=models=/response/share_holder.dart';
import '../../../../config/service/app_services.dart';
import '../../../../data/i_network_service.dart';
import '../../../../data/implementations/network_service.dart';
import '../../../../l10n/generated/l10n.dart';

class GeneralInfoTab extends StatefulWidget {
  const GeneralInfoTab({
    super.key,
    required this.stockModel,
  });

  final StockModel stockModel;

  @override
  State<GeneralInfoTab> createState() => _GeneralInfoTabState();
}

class _GeneralInfoTabState extends State<GeneralInfoTab> {
  late Future<CompanyInfo> companyInfo;
  final INetworkService iNetworkService = NetworkService();

  late Future<List<ShareHolders>> listShareHolder;

  @override
  void initState() {
    companyInfo =
        iNetworkService.getCompanyInfo(widget.stockModel.stockData.sym);
    listShareHolder = iNetworkService
        .getShareHolderCompany(widget.stockModel.stock.stockCode);

    super.initState();
  }

  bool isFull = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    final int leaderLength =
        !isFull && widget.stockModel.businnessLeaders!.length > 3
            ? 3
            : widget.stockModel.businnessLeaders!.length;
    return FutureBuilder<CompanyInfo>(
        future: companyInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            var info = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: themeMode.isLight
                          ? AppColors.neutral_06
                          : AppColors.text_black_1,
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
                                    S.of(context).Foundation_Day,
                                    style: textTheme.bodyMedium!.copyWith(
                                        color: themeMode.isLight
                                            ? AppColors.neutral_03
                                            : AppColors.neutral_07),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    info.foundDateString,
                                    style: textTheme.titleSmall?.copyWith(
                                        color: themeMode.isLight
                                            ? AppColors.neutral_03
                                            : AppColors.neutral_07),
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).Tax_code,
                                    style: textTheme.bodyMedium!.copyWith(
                                        color: themeMode.isLight
                                            ? AppColors.neutral_03
                                            : AppColors.neutral_07),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    info.taxCode ?? "",
                                    style: textTheme.titleSmall?.copyWith(
                                        color: themeMode.isLight
                                            ? AppColors.neutral_03
                                            : AppColors.neutral_07),
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
                                    S.of(context).Abbreviated_name,
                                    style: textTheme.bodyMedium!.copyWith(
                                        color: themeMode.isLight
                                            ? AppColors.neutral_03
                                            : AppColors.neutral_07),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    info.name ?? "",
                                    style: textTheme.titleSmall?.copyWith(
                                        color: themeMode.isLight
                                            ? AppColors.neutral_03
                                            : AppColors.neutral_07),
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).Agent,
                                    style: textTheme.bodyMedium!.copyWith(
                                        color: themeMode.isLight
                                            ? AppColors.neutral_03
                                            : AppColors.neutral_07),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    info.infoSupplier ?? "",
                                    style: textTheme.titleSmall?.copyWith(
                                        color: themeMode.isLight
                                            ? AppColors.neutral_03
                                            : AppColors.neutral_07),
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
                              launchUrl(
                                  Uri(scheme: 'tel', path: info.phone ?? ""));
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
                                style: textTheme.titleSmall
                                    ?.copyWith(color: AppColors.primary_01),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text(
                        "Ban lãnh đạo",
                        style: textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: themeMode.isLight
                                ? AppColors.neutral_06
                                : AppColors.text_black_1,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.stockModel.businnessLeaders?[i]
                                              .fullName ??
                                          "-",
                                      style: textTheme.labelMedium!.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.stockModel.businnessLeaders?[i]
                                              .position ??
                                          "-",
                                      style: AppTextStyle.bodySmall_8.copyWith(
                                          color: AppColors.neutral_04),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(child: LayoutBuilder(
                                builder: (context, ctx) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: widget
                                                .stockModel
                                                .businnessLeaders![i]
                                                .personalHeldPct! *
                                            ctx.maxWidth /
                                            300,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            color: AppColors.graph_2),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "${widget.stockModel.businnessLeaders?[i].personalHeldPct?.toString() ?? "-"}%",
                                        style: textTheme.labelMedium!.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  );
                                },
                              ))
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                      itemCount: leaderLength),
                  widget.stockModel.businnessLeaders!.length > 3
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              isFull = !isFull;
                            });
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                !isFull ? 'Xem thêm' : 'Thu gọn',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.primary_01),
                              )),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 24),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     "Cơ cấu cổ đông",
                  //     style: textTheme.titleMedium!
                  //         .copyWith(fontWeight: FontWeight.w700),
                  //   ),
                  // ),
                  // Visibility(
                  //   visible: widget.stockModel.businnessLeaders != null,
                  //   child: Container(
                  //     padding: const EdgeInsets.all(10),
                  //     decoration: const BoxDecoration(color: Colors.white),
                  //     child: AspectRatio(
                  //       aspectRatio: 1.3,
                  //       child: SfCircularChart(
                  //           palette: AppColors.graphColors,
                  //           legend: Legend(
                  //             isVisible: true,
                  //             overflowMode: LegendItemOverflowMode.wrap,
                  //             position: LegendPosition.bottom,
                  //           ),
                  //           annotations: <CircularChartAnnotation>[
                  //             CircularChartAnnotation(
                  //               height: "80%",
                  //               width: "80%",
                  //               widget: PhysicalModel(
                  //                 shape: BoxShape.circle,
                  //                 elevation: 10,
                  //                 shadowColor: Colors.black,
                  //                 color: Colors.white,
                  //                 child: Center(
                  //                     child: Text(
                  //                   "",
                  //                   style: textTheme.bodyMedium!.copyWith(
                  //                       color: AppColors.color_secondary,
                  //                       fontWeight: FontWeight.w700),
                  //                 )),
                  //               ),
                  //             ),
                  //           ],
                  //           series: <
                  //               DoughnutSeries<BusinnessLeaderModel, String>>[
                  //             DoughnutSeries<BusinnessLeaderModel, String>(
                  //               dataSource: widget.stockModel.businnessLeaders,
                  //               innerRadius: "75%%",
                  //               radius: "80%",
                  //               xValueMapper: (BusinnessLeaderModel data, _) =>
                  //                   data.fullName,
                  //               yValueMapper: (BusinnessLeaderModel data, _) =>
                  //                   data.personalHeldPct,
                  //               dataLabelMapper:
                  //                   (BusinnessLeaderModel data, _) =>
                  //                       "${data.personalHeldPct}%",
                  //               dataLabelSettings: const DataLabelSettings(
                  //                 isVisible: true,
                  //                 // Positioning the data label
                  //                 margin: EdgeInsets.all(0),
                  //                 labelPosition: ChartDataLabelPosition.outside,
                  //               ),
                  //             )
                  //           ]),
                  //     ),
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Cổ đông lớn",
                      style: textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<List<ShareHolders>>(
                      future: listShareHolder,
                      initialData: const [],
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data == null) return const SizedBox();
                          var list = snapshot.data!;

                          if (list.isEmpty) {
                            return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: themeMode.isLight
                                        ? Colors.white
                                        : AppColors.text_black_1),
                                child: Text(
                                  "Không có dữ liệu",
                                  style: textTheme.bodyMedium!
                                      .copyWith(color: AppColors.neutral_03),
                                ));
                          }

                          num sum = 0;
                          for (var element in list) {
                            {
                              sum = (sum + element.heldPct!);
                            }
                          }

                          if (sum < 100) {
                            list.add(ShareHolders(
                              heldPct: 100 - sum,
                              name: S.of(context).other,
                            ));
                          }

                          return Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: themeMode.isLight
                                      ? Colors.white
                                      : AppColors.text_black_1),
                              child: Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.3,
                                    child: SfCircularChart(
                                        palette: AppColors.graphColors,
                                        legend: Legend(
                                          isVisible: true,
                                          overflowMode:
                                              LegendItemOverflowMode.wrap,
                                          position: LegendPosition.bottom,
                                        ),
                                        annotations: <CircularChartAnnotation>[
                                          CircularChartAnnotation(
                                            height: "70%",
                                            width: "70%",
                                            widget: PhysicalModel(
                                              shape: BoxShape.circle,
                                              elevation: 10,
                                              shadowColor: Colors.white,
                                              color: Colors.white,
                                              child: Center(
                                                  child: Text(
                                                "",
                                                style: textTheme.bodyMedium!
                                                    .copyWith(
                                                        color: AppColors
                                                            .color_secondary,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              )),
                                            ),
                                          ),
                                        ],
                                        series: <DoughnutSeries<ShareHolders,
                                            String>>[
                                          DoughnutSeries<ShareHolders, String>(
                                            dataSource: list,
                                            innerRadius: "75%%",
                                            radius: "80%",
                                            xValueMapper:
                                                (ShareHolders data, _) =>
                                                    data.name,
                                            yValueMapper:
                                                (ShareHolders data, _) =>
                                                    data.heldPct,
                                            dataLabelMapper:
                                                (ShareHolders data, _) =>
                                                    "${data.heldPct}%",
                                            dataLabelSettings:
                                                DataLabelSettings(
                                                    isVisible: true,
                                                    // Positioning the data label
                                                    margin:
                                                        const EdgeInsets.all(0),
                                                    labelPosition:
                                                        ChartDataLabelPosition
                                                            .outside,
                                                    textStyle: TextStyle(
                                                        color: themeMode.isLight
                                                            ? Colors.black
                                                            : Colors.white)),
                                          )
                                        ]),
                                  ),
                                  ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12)),
                                            color: themeMode.isLight
                                                ? Colors.white
                                                : AppColors.bg_share_inside_nav,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  list[i].name ?? "-",
                                                  style: textTheme.labelMedium!
                                                      .copyWith(
                                                          height: 24 / 15,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                              Expanded(child: LayoutBuilder(
                                                builder: (context, ctx) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        width:
                                                            (list[i].heldPct ??
                                                                    0) *
                                                                ctx.maxWidth /
                                                                300,
                                                        height: 10,
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4)),
                                                            color: AppColors
                                                                .graph_2),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        "${list[i].heldPct?.toString() ?? "-"}%",
                                                        style: textTheme
                                                            .labelMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ))
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(height: 8);
                                      },
                                      itemCount: list.length),
                                ],
                              ));
                        }
                        return const SizedBox();
                      }),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }
          return const SizedBox();
        });
  }
}
