import 'dart:async';

import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';

import '../../../../../=models=/response/market/stock_industry.dart';
import '../../../../../data/i_data_center_service.dart';
import '../../../../../data/implementations/data_center_service.dart';
import '../../../../../l10n/generated/l10n.dart';

class HeapMapWidget extends StatefulWidget {
  const HeapMapWidget({super.key});

  @override
  State<HeapMapWidget> createState() => _HeapMapWidgetState();
}

class _HeapMapWidgetState extends State<HeapMapWidget>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  final IDataCenterService dataCenterService = DataCenterService();

  StreamController<List<String>> listIndustryStream =
      StreamController<List<String>>.broadcast();

  StreamController<List<StockIndustry>> listStockStream =
      StreamController<List<StockIndustry>>.broadcast();

  String? industry;

  @override
  void initState() {
    getListIndustry();
    super.initState();
  }

  Future<void> getListIndustry() async {
    try {
      var list = await dataCenterService.getListIndustry();
      listIndustryStream.sink.add(list);
      await getStockIndustry(list.first);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> getStockIndustry(String indus) async {
    industry = indus;
    searchController.text = industry ?? "";
    if (industry != null) {
      var listStock = await dataCenterService.getListStockByIndust(industry!);
      listStockStream.sink.add(listStock);
    }
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
          StreamBuilder<List<StockIndustry>>(
              stream: listStockStream.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    child: Text(S.of(context).loading),
                  );
                }
                if (snapshot.connectionState == ConnectionState.active) {
                  return HeapMapTree(
                    stock: snapshot.data!,
                    title: industry ?? "data",
                  );
                }
                return const SizedBox();
              })
        ],
      ),
    );
  }

  Widget get searchWidget {
    return StreamBuilder<List<String>>(
      stream: listIndustryStream.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var list = snapshot.data;
          return TypeAheadField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: searchController,
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(
                    () {
                      industry = null;
                    },
                  );
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.neutral_06,
                enabledBorder: InputBorder.none,
                hintText: S.of(context).find_sector,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    AppImages.search_appbar_icon,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ),
            suggestionsCallback: (text) async {
              return list!.toList().where((element) =>
                  element.toLowerCase().contains(text.toLowerCase()));
            },
            itemBuilder: (context, industry) {
              return ListTile(
                title: Text(industry),
              );
            },
            onSuggestionSelected: (suggestion) {
              getStockIndustry(suggestion);

              /// viết tiếp
            },
            noItemsFoundBuilder: (context) {
              return ListTile(
                title: Text(
                  S.of(context).invalid_industry,
                  style: TextStyle(
                      color: Theme.of(context).disabledColor, fontSize: 18.0),
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class HeapMapTree extends StatefulWidget {
  final List<StockIndustry> stock;
  final String title;

  const HeapMapTree({Key? key, required this.stock, required this.title})
      : super(key: key);

  @override
  State<HeapMapTree> createState() => _HeapMapTreeState();
}

class _HeapMapTreeState extends State<HeapMapTree> {
  late List<StockIndustry> stocks;

  @override
  void initState() {
    stocks = widget.stock;
    stocks.removeWhere((element) => element.gTGD == 0);
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
        Container(
          height: 200,
          color: Colors.grey,
          child: SfTreemap(
            dataCount: stocks.length,
            weightValueMapper: (int index) {
              return stocks[index].gTGD?.toDouble() ?? 0;
            },
            levels: <TreemapLevel>[
              TreemapLevel(
                groupMapper: (int index) => stocks[index].sTOCKCODE,
                colorValueMapper: (tile) {
                  return widget.stock[tile.indices[0]].stockColor;
                },
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
