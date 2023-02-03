import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';

import '../../../../../=models=/response/indContrib.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utilities/num_utils.dart';

class PiValueChart extends StatefulWidget {
  final Future<IndContrib> pIValue;

  const PiValueChart({Key? key, required this.pIValue}) : super(key: key);

  @override
  State<PiValueChart> createState() => _PiValueChartState();
}

class _PiValueChartState extends State<PiValueChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Top mã tự doanh mua ròng',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
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
                if(snapshot.data == null) return const SizedBox();
                var data = snapshot.data!.listMapValue;
                data.removeWhere((element) => element['ptvalue'] == 0);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                      height: 200,
                      color: Colors.grey,
                      child: SfTreemap(
                        dataCount: data.length,
                        weightValueMapper: (int index) {
                          return data[index]['ptvalue'] ?? 0.0;
                        },
                        levels: <TreemapLevel>[
                          TreemapLevel(
                            groupMapper: (int index) => data[index]['name'],
                            colorValueMapper: (tile) =>
                                data[tile.indices[0]]['ptcolor'],
                            tooltipBuilder:
                                (BuildContext context, TreemapTile tile) {
                              return Container(
                                padding: const EdgeInsets.all(2.5),
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Text(
                                  '${tile.group} : ${NumUtils.formatInteger(tile.weight)}',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                            labelBuilder:
                                (BuildContext context, TreemapTile tile) {
                              return Center(
                                child: Text(
                                  tile.group,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              );
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
