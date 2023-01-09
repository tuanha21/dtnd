import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/local/user_catalog.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_overview.dart';
import 'package:dtnd/ui/screen/market/logic/add_catalog_logic.dart';
import 'package:dtnd/ui/screen/market/widget/sheet/catalog_options_sheet.dart';
import 'package:dtnd/ui/screen/market/widget/sheet/create_catalog_sheet.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/input/search_stock.dart';
import 'package:flutter/material.dart';

class UserCatalogWidget extends StatefulWidget {
  const UserCatalogWidget({
    super.key,
  });
  @override
  State<UserCatalogWidget> createState() => _UserCatalogWidgetState();
}

class _UserCatalogWidgetState extends State<UserCatalogWidget> {
  final IDataCenterService dataCenterService = DataCenterService();
  final ILocalStorageService localStorageService = LocalStorageService();
  final IUserService userService = UserService();
  final TextEditingController addStockController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late final SavedCatalog userCatalog;
  LocalCatalog? currentCatalog;
  List<StockModel> listStocks = [];
  bool showInput = false;
  bool initialized = false;
  @override
  void initState() {
    super.initState();
    initCatalog();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.addListener(() {
        setState(() {
          showInput = focusNode.hasFocus;
        });
      });
    });
  }

  void initCatalog() async {
    try {
      userCatalog =
          localStorageService.getSavedCatalog(userService.token!.user)!;
    } catch (e) {
      setState(() {
        userCatalog = SavedCatalog(userService.token!.user);
      });
      await localStorageService.putSavedCatalog(userCatalog);
    }
    // if (userCatalog.catalogs.isEmpty) {
    //   final catalog = UserCatalog("Default");
    //   catalog.stocks.addAll(defaultListStock);
    //   userCatalog.catalogs.add(catalog);
    //   userCatalog.save();
    // }
    if (userCatalog.catalogs.isNotEmpty) {
      currentCatalog = userCatalog.catalogs.first;
      listStocks = await dataCenterService
          .getStockModelsFromStockCodes(currentCatalog!.stocks);
    }

    setState(() {
      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Widget? listCatalogsWidget;
    Widget? listStocksWidget;
    if (!initialized) {
      return Container();
    }
    if (userCatalog.catalogs.isEmpty) {
      listCatalogsWidget = Container();
    } else {
      listCatalogsWidget = ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount:
            userCatalog.catalogs.length > 5 ? 5 : userCatalog.catalogs.length,
        itemBuilder: (context, index) {
          final catalog = userCatalog.catalogs.elementAt(index);
          bool selected = false;
          if (currentCatalog!.name == catalog.name) {
            selected = true;
          }
          Widget element = Text(catalog.name);
          element = Material(
            child: InkWell(
              onTap: () async {
                final stocks = await dataCenterService
                    .getStockModelsFromStockCodes(catalog.stocks);
                setState(() {
                  currentCatalog = catalog;
                  listStocks.clear();
                  listStocks.addAll(stocks);
                });
                print(userCatalog.toString());
              },
              onLongPress: () {
                CatalogOptionsISheet(userCatalog, catalog).show(
                    context,
                    CatalogOptionsSheet(
                        savedCatalog: userCatalog, catalog: catalog));
              },
              child: Ink(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: selected ? AppColors.primary_01 : AppColors.neutral_05,
                ),
                child: Center(
                  child: DefaultTextStyle(
                      style: textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: selected
                              ? AppColors.neutral_07
                              : AppColors.neutral_04),
                      child: element),
                ),
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
            onTap: () async {
              // Navigator.of(context).pop(CreateCatalogCmd());
              await CreateCatalogISheet(userCatalog).show(
                  context,
                  CreateCatalogSheet(
                    savedCatalog: userCatalog,
                  ));
              final stocks =
                  await dataCenterService.getStockModelsFromStockCodes(
                      userCatalog.catalogs.last.stocks);
              setState(() {
                currentCatalog = userCatalog.catalogs.last;
                listStocks.clear();
                listStocks.addAll(stocks);
              });
              localStorageService.putSavedCatalog(userCatalog);
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

    if (currentCatalog == null) {
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
              currentCatalog!.stocks.add(suggestion.stockCode);
              userCatalog.save();
              localStorageService.putSavedCatalog(userCatalog);
              // localStorageService.putSavedCatalog(userCatalog);

              final StockModel model = (await dataCenterService
                      .getStockModelsFromStockCodes([suggestion.stockCode]))
                  .first;
              listStocks.add(model);
              setState(() {});
            },
          );
        }
        return Material(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                color: AppColors.neutral_06,
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
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              return SizedBox(
                height: 85,
                child: HomeMarketOverviewItem(
                  data: listStocks.elementAt(index),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              thickness: 2,
            ),
            itemCount: listStocks.length,
          ),
        ],
      );
    }

    listStocksWidget = Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.neutral_07,
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
        listCatalogsWidget,
        const SizedBox(height: 20),
        listStocksWidget,
        const SizedBox(height: 100),
      ],
    );
  }
}
