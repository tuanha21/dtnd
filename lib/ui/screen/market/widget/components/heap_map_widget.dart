import 'package:dtnd/ui/screen/market/controller/industry_tab_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';
import '../../../../../=models=/response/stock_data.dart';
import '../../../../../data/i_data_center_service.dart';
import '../../../../../data/implementations/data_center_service.dart';
import '../../../../../generated/l10n.dart';

class HeapMapWidget extends StatefulWidget {
  const HeapMapWidget({super.key});

  @override
  State<HeapMapWidget> createState() => _HeapMapWidgetState();
}

class _HeapMapWidgetState extends State<HeapMapWidget>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  final IDataCenterService dataCenterService = DataCenterService();

  MapEntry<String, dynamic>? industry;

  late Future<List<List<String>>> getCodeIndustry;

  @override
  void initState() {
    getCodeIndustry = Future.wait(listIndustry.entries
        .map((e) => dataCenterService.getSectors(e.key))
        .toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          searchWidget,
          const SizedBox(height: 18),
          FutureBuilder<List<List<String>>>(
              future: getCodeIndustry,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    child: Text(S.of(context).loading),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return HeapMapTree(
                          stock: snapshot.data![index],
                          title: industry?.value ??
                              listIndustry.entries.toList()[index].value,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      },
                      itemCount: snapshot.data!.length);
                }
                return const SizedBox();
              })
        ],
      ),
    );
  }

  Widget get searchWidget {
    return TypeAheadField<MapEntry<String, dynamic>>(
        textFieldConfiguration: TextFieldConfiguration(
            controller: searchController,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  industry = null;
                  getCodeIndustry = Future.wait(listIndustry.entries
                      .map((e) => dataCenterService.getSectors(e.key))
                      .toList());
                });
              }
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.neutral_06,
                enabledBorder: InputBorder.none,
                hintText: 'Tìm ngành..',
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    AppImages.search_appbar_icon,
                    height: 24,
                    width: 24,
                  ),
                ))),
        suggestionsCallback: (text) async {
          return listIndustry.entries.toList().where((element) =>
              element.value.toLowerCase().contains(text.toLowerCase()));
        },
        itemBuilder: (context, industry) {
          return ListTile(
            title: Text(industry.value),
          );
        },
        onSuggestionSelected: (suggestion) {
          searchController.text = suggestion.value;
          industry = suggestion;
          setState(() {
            getCodeIndustry =
                Future.wait([dataCenterService.getSectors(industry!.key)]);
          });
        },
        noItemsFoundBuilder: (context) {
          return ListTile(
              title: Text(
            'Ngành không hợp lệ',
            style: TextStyle(
                color: Theme.of(context).disabledColor, fontSize: 18.0),
          ));
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class HeapMapTree extends StatefulWidget {
  final List<String> stock;
  final String title;

  const HeapMapTree({Key? key, required this.stock, required this.title})
      : super(key: key);

  @override
  State<HeapMapTree> createState() => _HeapMapTreeState();
}

class _HeapMapTreeState extends State<HeapMapTree> {
  final IDataCenterService dataCenterService = DataCenterService();
  late Future<List<StockData>> listStock;

  @override
  void initState() {
    listStock = dataCenterService.getListStockData(widget.stock);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        const SizedBox(height: 10),
        FutureBuilder<List<StockData>>(
            future: listStock,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  child: Text(S.of(context).loading),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data;
                data?.removeWhere((element) => element.lot.value == 0);
                return Container(
                    height: 200,
                    color: Colors.grey,
                    child: SfTreemap(
                      dataCount: data!.length,
                      weightValueMapper: (int index) {
                        return data[index].lot.value?.toDouble() ?? 0.0;
                      },
                      levels: <TreemapLevel>[
                        TreemapLevel(
                          groupMapper: (int index) => data[index].sym,
                          colorValueMapper: (tile) =>
                              data[tile.indices[0]].color,
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
                    ));
              }
              return const SizedBox();
            }),
      ],
    );
  }
}
