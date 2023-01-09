import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/input/search_stock.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final IDataCenterService dataCenterService = DataCenterService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: S.of(context).search,
        showActions: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: SearchStockField<Stock>(
              suggestionsCallback: (String code) =>
                  dataCenterService.searchStocksBySym(code, maxSuggestions: 5),
              itemBuilder: (context, itemData) {
                return SizedBox(
                  height: 72,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: const BoxDecoration(
                        color: AppColors.neutral_06,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(itemData.stockCode),
                        Text(itemData.nameShort ?? "-"),
                      ],
                    ),
                  ),
                );
              },
              onSuggestionSelected: (suggestion) async {
                final String stock = suggestion.stockCode;
                setState(() {});
              },
            ),
          ),
          Expanded(
              child: ListView(
            children: [],
          ))
        ],
      ),
    );
  }
}
