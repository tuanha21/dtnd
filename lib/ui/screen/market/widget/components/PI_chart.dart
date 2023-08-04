import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';

import '../../../../../=models=/response/indContrib.dart';
import '../../../../../config/service/app_services.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utilities/num_utils.dart';
import '../../../../theme/app_color.dart';

class PiValueChart extends StatefulWidget {
  final Future<IndContrib> pIValue;

  const PiValueChart({Key? key, required this.pIValue}) : super(key: key);

  @override
  State<PiValueChart> createState() => _PiValueChartState();
}

class _PiValueChartState extends State<PiValueChart> {
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(height: 24),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   child: Text(
        //     'Top mã tự doanh mua ròng',
        //     style: Theme.of(context)
        //         .textTheme
        //         .labelMedium
        //         ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
        //   ),
        // ),
        const SizedBox(height: 20),
        FutureBuilder<IndContrib>(
            future: widget.pIValue,
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

                var take = data.length > 30 ? 30 : data.length;
                var data0 = data.reversed.take(take).toList();

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                      height: 200,
                      color: themeMode.isLight ? AppColors.bg_1 : AppColors.neutral_01,
                      child: SfTreemap(
                        dataCount: data0.length,
                        weightValueMapper: (int index) {
                          return data0[index]['ptvalue'] ?? 0.0;
                        },
                        levels: <TreemapLevel>[
                          TreemapLevel(
                            groupMapper: (int index) => data0[index]['name'],
                            colorValueMapper: (tile) =>
                                data0[tile.indices[0]]['ptcolor'],
                            tooltipBuilder:
                                (BuildContext context, TreemapTile tile) {
                              return Container(
                                padding: const EdgeInsets.all(2.5),
                                decoration:
                                      BoxDecoration(color: themeMode.isLight ? AppColors.bg_1 : AppColors.neutral_01),
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
