import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/local/volatility_warning_catalog.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/input/search_stock.dart';
import 'package:flutter/material.dart';

class UserWarningCatalogWidget extends StatefulWidget {
  const UserWarningCatalogWidget({
    super.key,
    required this.savedCatalog,
  });
  final SavedCatalog<VolatilityWarningCatalogStock> savedCatalog;
  @override
  State<UserWarningCatalogWidget> createState() =>
      _UserWarningCatalogWidgetState();
}

class _UserWarningCatalogWidgetState extends State<UserWarningCatalogWidget> {
  final IDataCenterService dataCenterService = DataCenterService();
  final TextEditingController addStockController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  LocalCatalog<VolatilityWarningCatalogStock>? currentCatalog;
  bool showInput = false;
  @override
  void initState() {
    super.initState();
    if (widget.savedCatalog.catalogs.isNotEmpty) {
      setState(() {
        currentCatalog = widget.savedCatalog.catalogs.first;
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.addListener(() {
        setState(() {
          showInput = focusNode.hasFocus;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Widget? listCatalogsWidget;
    Widget? listStocksWidget;
    if (widget.savedCatalog.catalogs.isEmpty) {
      listCatalogsWidget = Container();
    } else {
      listCatalogsWidget = ListView.separated(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) =>
            Text(widget.savedCatalog.catalogs.elementAt(index).name),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
      );
    }

    listCatalogsWidget = Row(
      children: [
        Material(
          child: InkWell(
            onTap: () {
              setState(() {
                showInput = true;
              });
              focusNode.requestFocus();
            },
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Ink(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 20,
                    child: Image.asset(
                      AppImages.add_icon,
                      color: AppColors.primary_01,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(S.of(context).add_stock)
                ],
              ),
            ),
          ),
        )
      ],
    );

    listStocksWidget = Builder(builder: (context) {
      if (showInput) {
        return SearchStockField<Stock>(
          focusNode: focusNode,
          suggestionsCallback: (String code) =>
              dataCenterService.searchStocksBySym(code, maxSuggestions: 5),
          itemBuilder: (context, itemData) {
            return SizedBox(
              height: 72,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
          onSuggestionSelected: (suggestion) {},
        );
      }
      return Material(
        child: InkWell(
          onTap: () {
            setState(() {
              showInput = true;
            });
            focusNode.requestFocus();
          },
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Ink(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              children: [
                SizedBox.square(
                  dimension: 20,
                  child: Image.asset(
                    AppImages.add_icon,
                    color: AppColors.primary_01,
                  ),
                ),
                const SizedBox(width: 20),
                Text(S.of(context).add_stock)
              ],
            ),
          ),
        ),
      );
    });

    listStocksWidget = Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.neutral_06,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [listStocksWidget],
      ),
    );

    return Column(
      children: [
        Row(
          children: [
            Text(
              S.of(context).following_catalog,
              style: textTheme.labelLarge,
            ),
          ],
        ),
        listCatalogsWidget,
        listStocksWidget,
      ],
    );
  }
}
