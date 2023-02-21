import 'dart:async';

import 'package:dtnd/=models=/algo/filter.dart';
import 'package:dtnd/=models=/algo/stock_filter.dart';
import 'package:flutter/material.dart';

import '../../../../../data/i_network_service.dart';
import '../../../../../data/implementations/network_service.dart';

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

  Future<void> getFilterApi() async {
    try {
      var list = await iNetworkService.getStockFilter(widget.filter);
      filterStream.sink.add(list);
    } catch (e) {
      filterStream.sink.addError("Có lỗi xảy ra");
    }
  }

  @override
  void initState() {
    getFilterApi();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filter.name ?? ""),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Container(),
          ],
        ),
      ),
    );
  }
}
