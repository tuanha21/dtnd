import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';

import '../../../../../=models=/response/market/ind_contrib.dart';
import '../../../../../config/service/app_services.dart';
import '../../../../../l10n/generated/l10n.dart';
import '../../../../../utilities/num_utils.dart';
import '../../../../theme/app_color.dart';

class FiChartValue extends StatefulWidget {
  final Future<IndContrib> fIValue;

  const FiChartValue({Key? key, required this.fIValue}) : super(key: key);

  @override
  State<FiChartValue> createState() => _FiChartValueState();
}

class _FiChartValueState extends State<FiChartValue> {
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                S.of(context).top_foreign_stocks_with_net_buying,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              const SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    backgroundColor: themeMode.isLight
                        ? AppColors.light_bg
                        : AppColors.neutral_01,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: themeMode.isLight
                              ? AppColors.light_bg
                              : AppColors.neutral_01,
                          borderRadius: BorderRadius.circular(8)),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          '${S.of(context).suggest_infomation_2} ${TimeUtilities.parseDateToString(DateTime.now())}',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                    ),
                  ),
                ),
                child: SvgPicture.asset(
                  AppImages.infoCircle,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        FutureBuilder<IndContrib>(
            future: widget.fIValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  child: Text(S.of(context).loading),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) return const SizedBox();
                var data = snapshot.data!.listMapValue;
                data.removeWhere((element) => element['ptvalue'] == 0);
                data.sort((a, b) => a['ptvalue'].compareTo(b['ptvalue']));

                var _take = data.length > 30 ? 30 : data.length;
                var _data = data.reversed.take(_take).toList();

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                      height: 200,
                      color: themeMode.isLight
                          ? AppColors.bg_1
                          : AppColors.neutral_01,
                      child: SfTreemap(
                        dataCount: _data.length,
                        weightValueMapper: (int index) {
                          return _data[index]['ptvalue'] ?? 0.0;
                        },
                        levels: <TreemapLevel>[
                          TreemapLevel(
                            groupMapper: (int index) => _data[index]['name'],
                            colorValueMapper: (tile) =>
                                _data[tile.indices[0]]['ptcolor'],
                            tooltipBuilder:
                                (BuildContext context, TreemapTile tile) {
                              return Container(
                                padding: const EdgeInsets.all(2.5),
                                decoration: BoxDecoration(
                                    color: themeMode.isLight
                                        ? AppColors.bg_1
                                        : AppColors.neutral_01),
                                child: Text(
                                  '${tile.group} : ${NumUtils.formatInteger(tile.weight)} ${S.of(context).million_lower}',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                            labelBuilder:
                                (BuildContext context, TreemapTile tile) {
                              return Center(
                                  child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      tile.group,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.light_bg),
                                    ),
                                    Text(
                                      NumUtils.formatInteger(tile.weight),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.light_bg),
                                    )
                                  ],
                                ),
                              ));
                            },
                          ),
                        ],
                      )),
                );
              }
              return const SizedBox();
            }),
      ],
    );
  }
}
