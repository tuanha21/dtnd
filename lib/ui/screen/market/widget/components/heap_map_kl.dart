import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';

import '../../../../../=models=/ui_model/field_tree_element_model.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utilities/num_utils.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("Danh sách ngành"),
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
                return  Container(
                  margin: const EdgeInsets.all(16),
                    height: 200,
                    color: Colors.grey,
                    child: SfTreemap(
                      dataCount: data.length,
                      weightValueMapper: (int index) {
                        return data[index].tOTALKLGD.toDouble() ;
                      },
                      levels: [
                        TreemapLevel(
                          groupMapper: (int index) => data[index].iNDUSTRY,
                          // colorValueMapper: (tile) {
                          //   return widget.stock[tile.indices[0]].stockColor;
                          // },
                          tooltipBuilder: (BuildContext context, TreemapTile tile) {
                            return Container(
                              padding: const EdgeInsets.all(2.5),
                              decoration: const BoxDecoration(color: Colors.white),
                              child: Text(
                                '${tile.group} : ${NumUtils.formatInteger(tile.weight)}',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                          labelBuilder: (BuildContext context, TreemapTile tile) {
                            return Center(
                              child: Text(
                                tile.group,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        )
                      ],
                    ));
              }
              return const SizedBox();
            })
      ],
    );
  }
}
