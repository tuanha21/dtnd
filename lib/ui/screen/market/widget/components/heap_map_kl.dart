import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/screen/stock_detail/stock_detail_screen.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
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

  final List<Pair<String, StockModel>> listStock = [];

  @override
  initState() {
    listField = dataCenterService.getListIndustryHeatMap(top: 10, type: "KL");
    super.initState();
  }

  bool isVol = true;

  void toStockDetail(String stockCode) async {
    if (listStock.isNotEmpty) {
      final contain =
          listStock.firstWhereOrNull((element) => element.first == stockCode);
      if (contain != null) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StockDetailScreen(stockModel: contain.second),
        ));
        return;
      } else {
        final model =
            await dataCenterService.getStocksModelsFromStockCodes([stockCode]);
        final StockModel stock;
        if (model?.isNotEmpty ?? false) {
          stock = model!.first;
        } else {
          return;
        }
        listStock.add(Pair(stockCode, stock));
        if (mounted) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StockDetailScreen(stockModel: stock),
          ));
        }
        return;
      }
    } else {
      final model =
          await dataCenterService.getStocksModelsFromStockCodes([stockCode]);
      final StockModel stock;
      if (model?.isNotEmpty ?? false) {
        stock = model!.first;
      } else {
        return;
      }
      listStock.add(Pair(stockCode, stock));
      if (mounted) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StockDetailScreen(stockModel: stock),
        ));
      }
      return;
    }
  }

  @override
  void dispose() {
    dataCenterService.removeStockModelsFromStockCodes(
        listStock.map((e) => e.first).toList());
    super.dispose();
  }

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
              const Text("Top cổ phiếu giao dịch theo ngành"),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isVol = !isVol;
                    listField = dataCenterService.getListIndustryHeatMap(
                        top: 10, type: isVol ? "KL" : "GT");
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
                if (!snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Center(
                        child: Image.asset(
                          AppImages.scene,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  );
                }

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
                        crossAxisCellCount: idx > 7 ? 2 : 4,
                        mainAxisCellCount: 2,
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
                                    onSelectionChanged: (value) =>
                                        toStockDetail(value.group),
                                    levels: [
                                      TreemapLevel(
                                        groupMapper: (int index) {
                                          // print('index: ' + index.toString());
                                          // if (index > 4)
                                          //   return listStock[index].sTOCKCODE;
                                          // return listStock[index].sTOCKCODE;
                                          return (listStock[index].sTOCKCODE ??
                                                  '') +
                                              "/" +
                                              listStock[index]
                                                  .pERCENTCHANGE
                                                  .toString() +
                                              '%';
                                        },
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
                                              '${tile.group} : ${NumUtils.formatInteger(tile.weight * 10)}',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        },
                                        labelBuilder: (BuildContext context,
                                            TreemapTile tile) {
                                          final gr = (tile.group).split('/');
                                          if (gr.length < 2) {
                                            return Center(
                                              child: Text(
                                                tile.group,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: AppColors.light_bg),
                                              ),
                                            );
                                          }

                                          return Center(
                                            child: SingleChildScrollView(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text((tile.group).split('/')[0],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: AppColors
                                                            .light_bg)),
                                                Text((tile.group).split('/')[1],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.light_bg))
                                              ],
                                            )),
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
