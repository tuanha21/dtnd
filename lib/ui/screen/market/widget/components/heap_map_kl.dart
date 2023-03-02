import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';

import '../../../../../=models=/ui_model/field_tree_element_model.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utilities/num_utils.dart';
import '../../../../theme/app_color.dart';

class HeapMapKL extends StatefulWidget {
  const HeapMapKL({Key? key}) : super(key: key);

  @override
  State<HeapMapKL> createState() => _HeapMapKLState();
}

class _HeapMapKLState extends State<HeapMapKL> {
  IDataCenterService dataCenterService = DataCenterService();

  late Future<List<FieldTreeModel>> listField;

  @override
  initState() {
    listField = dataCenterService.getListIndustryHeatMap(top: 8, type: "KL");
    super.initState();
  }

  bool isVol = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Top cổ phiếu giao dutch theo ngành"),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isVol = !isVol;
                    listField = dataCenterService.getListIndustryHeatMap(
                        top: 8, type: isVol ? "KL" : "GT");
                  });
                },
                child: Row(
                  children: [
                    const Icon(Icons.arrow_drop_down,
                        color: AppColors.primary_01),
                    Text(isVol ? "Khối lượng" : 'Giá trị',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: AppColors.primary_01))
                  ],
                ),
              )
            ],
          ),
        ),
        FutureBuilder<List<FieldTreeModel>>(
            future: listField,
            initialData: const [],
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  child: Text(S.of(context).loading),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!;
                data.removeWhere((element) => element.tOTALKLGD == 0);

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: List<Widget>.generate(data.length, (idx) {
                      var listStock = data[idx].stocks;
                      if (isVol) {
                        listStock.removeWhere((element) {
                          return element.kLGD == 0 || element.kLGD == null;
                        });
                      } else {
                        listStock.removeWhere((element) {
                          return element.gTGD == 0 || element.gTGD == null;
                        });
                      }
                      return StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: idx % 2 == 0 ? 2 : 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data[idx].iNDUSTRY),
                            const SizedBox(height: 5),
                            Expanded(
                              child: Container(
                                  color: Colors.grey,
                                  child: SfTreemap(
                                    dataCount: listStock.length,
                                    weightValueMapper: (int index) {
                                      if (isVol) {
                                        return listStock[index]
                                                .kLGD
                                                ?.toDouble() ??
                                            0;
                                      }
                                      return listStock[index]
                                              .gTGD
                                              ?.toDouble() ??
                                          0;
                                    },
                                    levels: [
                                      TreemapLevel(
                                        groupMapper: (int index) =>
                                            listStock[index].sTOCKCODE,
                                        colorValueMapper: (tile) {
                                          return listStock[tile.indices[0]]
                                              .stockColor;
                                        },
                                        tooltipBuilder: (BuildContext context,
                                            TreemapTile tile) {
                                          return Container(
                                            padding: const EdgeInsets.all(2.5),
                                            decoration: const BoxDecoration(
                                                color: Colors.white),
                                            child: Text(
                                              '${tile.group} : ${NumUtils.formatInteger(tile.weight)}',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        },
                                        labelBuilder: (BuildContext context,
                                            TreemapTile tile) {
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
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                );
              }
              return const SizedBox();
            })
      ],
    );
  }
}
