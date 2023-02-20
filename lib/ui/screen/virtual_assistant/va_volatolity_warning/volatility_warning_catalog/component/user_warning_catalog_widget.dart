import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_overview.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/volatility_warning_catalog/logic/add_catalog_process.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/input/search_stock.dart';
import 'package:flutter/material.dart';

class UserWarningCatalogWidget extends StatefulWidget {
  const UserWarningCatalogWidget({
    super.key,
    required this.savedCatalog,
  });
  final SavedCatalog savedCatalog;
  @override
  State<UserWarningCatalogWidget> createState() =>
      _UserWarningCatalogWidgetState();
}

class _UserWarningCatalogWidgetState extends State<UserWarningCatalogWidget> {
  final IDataCenterService dataCenterService = DataCenterService();
  final TextEditingController addStockController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  LocalCatalog? currentCatalog;
  List<StockModel>? listStocks;
  bool showInput = false;
  bool initialized = false;
  @override
  void initState() {
    super.initState();
    if (widget.savedCatalog.catalogs.isNotEmpty) {
      setState(() {
        currentCatalog = widget.savedCatalog.catalogs.first;
      });
      initCatalog();
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.addListener(() {
        setState(() {
          showInput = focusNode.hasFocus;
        });
      });
    });
  }

  void initCatalog() async {
    if (currentCatalog?.listStock.isEmpty ?? true) {
      return;
    }
    listStocks = await dataCenterService
        .getStockModelsFromStockCodes(currentCatalog!.listStock);
    setState(() {
      initialized = true;
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
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.savedCatalog.catalogs.length > 5
            ? 5
            : widget.savedCatalog.catalogs.length,
        itemBuilder: (context, index) {
          final catalog = widget.savedCatalog.catalogs.elementAt(index);
          bool selected = false;
          if (currentCatalog!.name == catalog.name) {
            selected = true;
          }
          Widget element = Text(catalog.name);
          element = Material(
            child: InkWell(
              onTap: () {
                setState(() {
                  currentCatalog = catalog;
                });
              },
              child: Ink(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: selected ? AppColors.primary_01 : AppColors.neutral_05,
                ),
                child: element,
              ),
            ),
          );
          return element;
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      );
    }

    listCatalogsWidget = Row(
      children: [
        Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop(CreateCatalogCmd());
            },
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: Ink(
              padding: const EdgeInsets.all(9),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: AppColors.neutral_06,
              ),
              child: SizedBox.square(
                dimension: 10,
                child: Image.asset(
                  AppImages.add_icon,
                  color: AppColors.primary_01,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(height: 28, child: listCatalogsWidget),
      ],
    );

    if (currentCatalog == null || listStocks == null) {
      listStocksWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(S.of(context).empty_catalog),
        ],
      );
    } else {
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
            onSuggestionSelected: (suggestion) async {
              final model = (await dataCenterService
                      .getStockModelsFromStockCodes([suggestion.stockCode]))
                  ?.first;
              final String stock = model?.stock.stockCode ?? "";
              currentCatalog!.listStock.add(stock);
              setState(() {});
            },
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
                      AppImages.add_rounded_icon,
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

      listStocksWidget = Column(
        children: [
          listStocksWidget,
          Builder(builder: (context) {
            double height = 0;
            if (currentCatalog!.listStock.length < 5) {
              height = 100.0 * currentCatalog!.listStock.length;
            } else {
              height = 85 * 5;
            }

            return SizedBox(
              height: height,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 85,
                    child: HomeMarketOverviewItem(
                      data: listStocks!.elementAt(index),
                      dataCenterService: dataCenterService,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  thickness: 2,
                ),
                itemCount: currentCatalog!.listStock.length,
              ),
            );
          }),
        ],
      );
    }

    listStocksWidget = Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.neutral_06,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          listStocksWidget,
        ],
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
        const SizedBox(height: 15),
        listCatalogsWidget,
        const SizedBox(height: 20),
        listStocksWidget,
      ],
    );
  }
}
