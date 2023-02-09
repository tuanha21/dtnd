import 'package:dtnd/=models=/response/business_profile_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final int leaderLength = widget.stockModel.businnessLeaders!.length > 4
        ? 4
        : widget.stockModel.businnessLeaders!.length;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
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
                        Text(
                          "-",
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
                        Text(
                          "-",
                          style: textTheme.titleSmall,
                        ),
                      ],
                    ))
                  ],
                ),
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
                        Text(
                          "-",
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
                        Text(
                          "-",
                          style: textTheme.titleSmall,
                        ),
                      ],
                    ))
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      AppImages.call,
                      width: 15,
                    ),
                    Text(
                      "-",
                      style: textTheme.titleSmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      AppImages.global,
                      width: 15,
                    ),
                    Text(
                      "-",
                      style: textTheme.titleSmall,
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "Thành viên Hội đồng quản trị",
                style:
                    textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          for (int i = 0; i < leaderLength; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: AppColors.neutral_06,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.stockModel.businnessLeaders
                                  ?.elementAt(i)
                                  .fullName ??
                              "-",
                          style: textTheme.labelMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.stockModel.businnessLeaders
                                  ?.elementAt(i)
                                  .position ??
                              "-",
                          style: AppTextStyle.bodySmall_8
                              .copyWith(color: AppColors.neutral_04),
                        )
                      ],
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: (widget.stockModel.businnessLeaders
                                          ?.elementAt(i)
                                          .personalHeldPct ??
                                      1)
                                  .toDouble() *
                              2,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              color: AppColors.graphColors.elementAt(i)),
                        ),
                        Text(
                          "${widget.stockModel.businnessLeaders?.elementAt(i).personalHeldPct?.toString() ?? "-"}%",
                          style: textTheme.labelMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          Row(
            children: [
              Text(
                "Cơ cấu cổ đông",
                style:
                    textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.white),
            child: AspectRatio(
              aspectRatio: 1.3,
              child: SfCircularChart(
                  palette: AppColors.graphColors,
                  // tooltipBehavior: TooltipBehavior(
                  //     enable: true,
                  //     color: AppColors.neutral_04,
                  //     builder: (dynamic data, dynamic point, dynamic series,
                  //         int pointIndex, int seriesIndex) {
                  //       final String _value = UtilFormat.formatMoney(
                  //           data.accountType == AccountType.MARGIN
                  //               ? data.totalEquity
                  //               : data.assets);
                  //       final AccountType _key = data.accountType;
                  //       return Container(
                  //           padding: const EdgeInsets.all(10),
                  //           decoration: const BoxDecoration(
                  //               borderRadius: BorderRadius.all(Radius.circular(8))),
                  //           child: Text(
                  //             '${_key.name} : ${_value} đ',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 12,
                  //             ),
                  //           ));
                  //     }),
                  legend: Legend(
                    isVisible: true,
                    // Templating the legend item
                    overflowMode: LegendItemOverflowMode.wrap,
                    position: LegendPosition.bottom,
                    // legendItemBuilder:
                    //     (String name, dynamic series, dynamic point, int index) {
                    //   return SizedBox(height: 20, width: 10, child: Text(name));
                    // },
                  ),
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                      height: "80%",
                      width: "80%",
                      widget: PhysicalModel(
                        shape: BoxShape.circle,
                        elevation: 10,
                        shadowColor: Colors.black,
                        color: Colors.white,
                        child: Center(
                            child: Text(
                          "",
                          style: textTheme.bodyMedium!.copyWith(
                              color: AppColors.color_secondary,
                              fontWeight: FontWeight.w700),
                        )),
                      ),
                    ),
                  ],
                  series: <DoughnutSeries<BusinnessLeaderModel, String>>[
                    DoughnutSeries<BusinnessLeaderModel, String>(
                      dataSource: widget.stockModel.businnessLeaders,
                      innerRadius: "75%%",
                      radius: "80%",
                      xValueMapper: (BusinnessLeaderModel data, _) =>
                          data.fullName,
                      yValueMapper: (BusinnessLeaderModel data, _) =>
                          data.personalHeldPct,
                      dataLabelMapper: (BusinnessLeaderModel data, _) =>
                          "${data.personalHeldPct}%",
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        // Positioning the data label
                        margin: EdgeInsets.all(0),
                        labelPosition: ChartDataLabelPosition.outside,
                      ),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
