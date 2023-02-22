import 'dart:async';

import 'package:dtnd/=models=/algo/filter.dart';
import 'package:dtnd/=models=/algo/stock_filter.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../../../data/i_network_service.dart';
import '../../../../../data/implementations/network_service.dart';
import '../../../../theme/app_color.dart';
import '../../../../widget/my_appbar.dart';
import '../../filter_enum.dart';

class ListStockFilter extends StatefulWidget {
  final Filter filter;

  const ListStockFilter({Key? key, required this.filter}) : super(key: key);

  @override
  State<ListStockFilter> createState() => _ListStockFilterState();
}

class _ListStockFilterState extends State<ListStockFilter> {
  final INetworkService iNetworkService = NetworkService();

  StreamController<List<StockFilter>> filterStream =
      StreamController.broadcast();

  late List<StockFilter> listStock;

  List<String> listFilterHeader = [];

  late LinkedScrollControllerGroup _controllers;

  late ScrollController _letters;
  late ScrollController _numbers;

  Future<void> getFilterApi() async {
    try {
      var list = await iNetworkService.getStockFilter(widget.filter);
      filterStream.sink.add(list);
      listStock = list;
    } catch (e) {
      filterStream.sink.addError("Có lỗi xảy ra");
    }
  }

  @override
  void initState() {
    _controllers = LinkedScrollControllerGroup();
    _letters = _controllers.addAndGet();
    _numbers = _controllers.addAndGet();
    getFilterApi();
    getListHead(widget.filter);
    super.initState();
  }

  Map get listFilterMap {
    Map<String, dynamic> map = {};
    for (var element in FilterEnum.values) {
      map.addAll(element.data);
    }
    return map;
  }

  void getListHead(Filter filter) {
    listFilterHeader = [
      'Sàn',
      "Ngành",
    ];
    for (var element in filter.list) {
      if (!listFilterHeader.contains(element.code)) {
        listFilterHeader.add(element.code!);
      }
    }
  }

  List<Widget> _buildCells(int count) {
    return List.generate(
      count,
      (index) {
        return Container(
          alignment: Alignment.centerLeft,
          height: 36,
          width: 90,
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              color: index % 2 == 1
                  ? AppColors.neutral_04
                  : AppColors.neutral_04.withOpacity(0.5)),
          child: Text(listStock[index].sECURITYCODE ?? "",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.neutral_02, fontWeight: FontWeight.w600)),
        );
      },
    );
  }

  int maxLength = 1;

  List<Widget> _buildCellsHeader(int count) {
    return List.generate(
      count,
      (index) {
        var text = "";
        if (index <= 1) {
          text = listFilterHeader[index];
        } else {
          text = listFilterMap[listFilterHeader[index]];
        }
        return Container(
          alignment: index <= 1 ? Alignment.centerLeft : Alignment.centerRight,
          width: index == 0 ? 70 : 140,
          child: Text(text,
              textAlign: index <= 1 ? TextAlign.left : TextAlign.right,
              maxLines: 4,
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.neutral_02, fontWeight: FontWeight.w600)),
        );
      },
    );
  }

  List<Widget> _buildCells2(int count, int indexCell) {
    return List.generate(
      count,
      (index) {
        String text = "";
        if (index == 0) {
          text = listStock[indexCell].eXCHANGECODE ?? "";
        } else if (index == 1) {
          text = listStock[indexCell].iNDUSTRYNAME ?? "";
        } else {
          var map = listStock[indexCell].toJson();
          if (map.containsKey(listFilterHeader[index])) {
            text =
                NumUtils.formatInteger(map[listFilterHeader[index].toString()]);
          }
        }
        return Container(
          alignment: index <= 1 ? Alignment.centerLeft : Alignment.centerRight,
          height: 36,
          width: index == 0 ? 70 : 140,
          child: Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.neutral_02, fontWeight: FontWeight.w600)),
        );
      },
    );
  }

  List<Widget> _buildRows(int count) {
    return List.generate(
      count,
      (index) {
        return Container(
          decoration: BoxDecoration(
              color: index % 2 == 1
                  ? AppColors.neutral_04
                  : AppColors.neutral_04.withOpacity(0.5)),
          child: Row(
            children: _buildCells2(listFilterHeader.length, index),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: widget.filter.name ?? ""),
      body: StreamBuilder<List<StockFilter>>(
          stream: filterStream.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null) return const SizedBox();
              return Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 90,
                              height: 60,
                              padding: const EdgeInsets.only(left: 20),
                              decoration: const BoxDecoration(
                                  color: AppColors.neutral_04),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Mã CK",
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                controller: _letters,
                                child: Column(
                                  children: _buildCells(listStock.length),
                                ),
                              ),
                            )
                          ],
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: AppColors.neutral_04),
                                  child: SizedBox(
                                    height: 60,
                                    child: Row(
                                      children: _buildCellsHeader(
                                          listFilterHeader.length),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    controller: _numbers,
                                    child: Column(
                                      children: _buildRows(listStock.length),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     child: const Text('Chỉnh sửa bộ lọc'),
                  //   ),
                  // )
                ],
              );
            }
            return const SizedBox();
          }),
    );
  }
}
