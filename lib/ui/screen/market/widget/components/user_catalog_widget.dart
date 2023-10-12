import 'dart:async';

import 'package:dtnd/=models=/local/i_local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/response/market/stock_model.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/input/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../=models=/local/user_catalog.dart';
import '../../../../../=models=/response/market/stock.dart';
import '../../../../../config/service/app_services.dart';
import '../../../../../l10n/generated/l10n.dart';
import '../../../../../utilities/logger.dart';
import '../../logic/add_catalog_logic.dart';
import '../sheet/catalog_options_sheet.dart';
import '../sheet/create_catalog_sheet.dart';
import '../widget/stock_component.dart';
import '../widget/stock_widget_bottom.dart';

class UserCatalogWidget extends StatefulWidget {
  const UserCatalogWidget({
    super.key,
  });

  @override
  State<UserCatalogWidget> createState() => _UserCatalogWidgetState();
}

class _UserCatalogWidgetState extends State<UserCatalogWidget> {
  final DataCenterService dataCenterService = DataCenterService();
  final ILocalStorageService localStorageService = LocalStorageService();
  final IUserService userService = UserService();

  final TextEditingController addStockController = TextEditingController();
  late SavedCatalog savedCatalog;

  late LocalCatalog currentCatalog;

  late Future<List<StockModel>?> listStocks = Future.value([]);

  late String user;

  int get currentCatalogIndex => savedCatalog.catalogs
      .indexWhere((element) => element.name == currentCatalog.name);

  final LocalCatalog defaultCatalog = UserCatalog(
      "VN30",
      "ACB,BCM,BID,BVH,CTG,FPT,GAS,GVR,HDB,HPG,MBB,MSN,MWG,NVL,PDR,PLX,POW,SAB,SSI,STB,TCB,TPB,VCB,VHM,VIB,VIC,VJC,VNM,VPB,VRE"
          .split(","));

  bool isPercent = false;
  bool priceUp = true;
  bool upColumn = true;

  @override
  void initState() {
    super.initState();
    initCatalog();
  }

  void initCatalog() {
    if (userService.token.value == null) {
      user = "default";
    } else {
      user = userService.token.value!.user;
    }
    savedCatalog = localStorageService.getSavedCatalog(user);
    currentCatalog = defaultCatalog;
    listStocks = dataCenterService
        .getStocksModelsFromStockCodes(currentCatalog.listData);
    // if (savedCatalog.catalogs.isNotEmpty) {
    //   currentCatalog = savedCatalog.catalogs.first;
    //   if (currentCatalog.listStock.isNotEmpty) {
    //     listStocks = dataCenterService
    //         .getStockModelsFromStockCodes(currentCatalog.listStock);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final themeMode = AppService.instance.themeMode.value;

    final Widget sortArrow = Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Opacity(
            opacity: priceUp ? 1.0 : 0.3,
            child: const Icon(
              Icons.expand_less_rounded,
              size: 12,
            ),
          ),
          Opacity(
            opacity: !priceUp ? 1.0 : 0.3,
            child: const Icon(
              Icons.expand_more_rounded,
              size: 12,
            ),
          ),
        ],
      ),
    );

    final Widget sortColumn = Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Opacity(
            opacity: upColumn ? 1.0 : 0.3,
            child: const Icon(
              Icons.expand_less_rounded,
              size: 12,
            ),
          ),
          Opacity(
            opacity: !upColumn ? 1.0 : 0.3,
            child: const Icon(
              Icons.expand_more_rounded,
              size: 12,
            ),
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(alignment: Alignment.centerLeft, child: rowCatalog()),
        ),
        Visibility(
          visible: savedCatalog.catalogs.isNotEmpty &&
              currentCatalog.name != defaultCatalog.name,
          child: Container(
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: themeMode.isLight
                    ? AppColors.neutral_06
                    : AppColors.neutral_01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    await updateCatalog(currentCatalog);
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.edit2,
                        color: AppColors.primary_01,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        S.of(context).edit,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: AppColors.primary_01,
                                fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            BottomAddStock(localCatalog: currentCatalog));
                    setState(() {
                      savedCatalog.catalogs[currentCatalogIndex] =
                          currentCatalog;
                      localStorageService.putSavedCatalog(savedCatalog);
                      if (currentCatalog.listData.isNotEmpty) {
                        listStocks =
                            dataCenterService.getStocksModelsFromStockCodes(
                                currentCatalog.listData);
                      } else {
                        listStocks = Future.value([]);
                      }
                    });
                  },
                  child: SvgPicture.asset(
                    AppImages.add_square,
                    color: AppColors.primary_01,
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 8),
              Expanded(
                flex: 25,
                child: Text(
                  S.of(context).stock_code,
                  style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.neutral_04),
                ),
              ),
              Expanded(
                flex: 25,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      priceUp = !priceUp;
                      listStocks.then(
                        (stockList) {
                          if (stockList != null) {
                            if (priceUp) {
                              stockList.sort(
                                (a, b) => ((a.stockData.lastPrice.value == 0
                                            ? a.stockData.r.value
                                            : a.stockData.lastPrice.value) ??
                                        0)
                                    .toDouble()
                                    .compareTo(
                                      ((b.stockData.lastPrice.value == 0
                                                  ? b.stockData.r.value
                                                  : b.stockData.lastPrice
                                                      .value) ??
                                              0)
                                          .toDouble(),
                                    ),
                              );
                            } else {
                              stockList.sort(
                                (a, b) => ((b.stockData.lastPrice.value == 0
                                            ? b.stockData.r.value
                                            : b.stockData.lastPrice.value) ??
                                        0)
                                    .toDouble()
                                    .compareTo(
                                      ((a.stockData.lastPrice.value == 0
                                                  ? a.stockData.r.value
                                                  : a.stockData.lastPrice
                                                      .value) ??
                                              0)
                                          .toDouble(),
                                    ),
                              );
                            }
                          } else {
                            print('error');
                          }
                        },
                      );
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).price,
                        style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.neutral_04),
                      ),
                      sortArrow,
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 25,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPercent = !isPercent;
                    });
                  },
                  child: Text(
                    isPercent ? "<%>" : "<+/->",
                    style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.neutral_04),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 25,
                child: GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        upColumn = !upColumn;
                        listStocks.then(
                          (stockList) {
                            if (stockList != null) {
                              if (upColumn) {
                                stockList.sort((a, b) =>
                                    (a.stockData.lot.value ?? 0)
                                        .toDouble()
                                        .compareTo((b.stockData.lot.value ?? 0)
                                            .toDouble()));
                              } else {
                                stockList.sort((a, b) =>
                                    (b.stockData.lot.value ?? 0)
                                        .toDouble()
                                        .compareTo((a.stockData.lot.value ?? 0)
                                            .toDouble()));
                              }
                            } else {
                              print('error');
                            }
                          },
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        S.of(context).volumn,
                        style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.neutral_04),
                        textAlign: TextAlign.center,
                      ),
                      sortColumn
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: FutureBuilder<List<StockModel>?>(
            future: listStocks,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var list = snapshot.data;
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var stock = dataCenterService.listStockReg.firstWhere(
                          (element) =>
                              element.stock.stockCode ==
                              list[index].stock.stockCode);
                      return defaultCatalog.name != currentCatalog.name
                          ? Slidable(
                              endActionPane: ActionPane(
                                extentRatio: 0.25,
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    // An action can be bigger than the others.
                                    onPressed: (BuildContext context) {
                                      setState(
                                        () {
                                          currentCatalog.listData.remove(
                                              list[index].stock.stockCode);
                                          savedCatalog.catalogs[
                                                  currentCatalogIndex] =
                                              currentCatalog;
                                          localStorageService
                                              .putSavedCatalog(savedCatalog);
                                          if (currentCatalog
                                              .listData.isNotEmpty) {
                                            listStocks = dataCenterService
                                                .getStocksModelsFromStockCodes(
                                                    currentCatalog.listData);
                                          } else {
                                            listStocks = Future.value([]);
                                          }
                                        },
                                      );
                                    },
                                    backgroundColor: AppColors.semantic_03,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete_outline,
                                    spacing: 0,
                                  ),
                                ],
                              ),
                              child: StockComponent(
                                index: index,
                                model: stock,
                                isPercent: isPercent,
                              ),
                            )
                          : StockComponent(
                              index: index,
                              model: stock,
                              isPercent: isPercent,
                            );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 2,
                        height: 0,
                        color: themeMode.isLight
                            ? const Color.fromRGBO(245, 248, 255, 1)
                            : null,
                      );
                    },
                    itemCount: list!.length);
              }
              return const SizedBox();
            },
          ),
        )
      ],
    );
  }

  Widget rowCatalog() {
    final themeMode = AppService.instance.themeMode.value;
    // if (savedCatalog.catalogs.isEmpty) {
    //   return GestureDetector(
    //     onTap: addCatalog,
    //     child: Container(
    //       padding: const EdgeInsets.all(18),
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(12),
    //           color: AppColors.neutral_06),
    //       child: Row(
    //         children: [
    //           SvgPicture.asset(
    //             AppImages.add_square,
    //             color: AppColors.primary_01,
    //           ),
    //           const SizedBox(width: 8),
    //           Text(
    //             'Tạo danh mục theo dõi',
    //             style: textTheme.labelMedium?.copyWith(
    //                 color: AppColors.primary_01, fontWeight: FontWeight.w700),
    //           )
    //         ],
    //       ),
    //     ),
    //   );
    // }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: addCatalog,
            child: Container(
              decoration: BoxDecoration(
                color: themeMode.isLight
                    ? const Color.fromRGBO(236, 241, 253, 1)
                    : AppColors.neutral_03,
                borderRadius: BorderRadius.circular(4),
              ),
              height: 28,
              width: 28,
              alignment: Alignment.center,
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(width: 4),
          Row(
            children: List<Widget>.generate(
              savedCatalog.catalogs.length + 1,
              (index) {
                if (index == 0) {
                  return GestureDetector(
                    onTap: () {
                      onTapChangeCatalog(defaultCatalog);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          right:
                              index == savedCatalog.catalogs.length ? 0 : 10),
                      decoration: BoxDecoration(
                        color: defaultCatalog.name == currentCatalog.name
                            ? AppColors.text_blue
                            : AppColors.neutral_04,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      child: Text(
                        defaultCatalog.name,
                        style: AppTextStyle.bodyMedium_14
                            .copyWith(color: AppColors.light_bg),
                      ),
                    ),
                  );
                }
                var catalog = savedCatalog.catalogs[index - 1];
                return GestureDetector(
                  onTap: () {
                    onTapChangeCatalog(catalog);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        right: index == savedCatalog.catalogs.length ? 0 : 10),
                    decoration: BoxDecoration(
                      color: catalog.name == currentCatalog.name
                          ? AppColors.text_blue
                          : AppColors.neutral_04,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: 28,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    child: Text(
                      catalog.name,
                      style: AppTextStyle.bodyMedium_14
                          .copyWith(color: AppColors.light_bg),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateCatalog(LocalCatalog catalog) async {
    var res = await CatalogOptionsISheet(savedCatalog, catalog).show(
      context,
      CatalogOptionsSheet(savedCatalog: savedCatalog, catalog: catalog),
    );
    if (res.runtimeType == NextCmd) {
      setState(
        () {
          if (res?.data == true) {
            if (savedCatalog.catalogs.isNotEmpty) {
              currentCatalog = savedCatalog.catalogs.last;
              listStocks = dataCenterService
                  .getStocksModelsFromStockCodes(currentCatalog.listData);
            } else {
              listStocks = Future.value([]);
            }
          }
        },
      );
    }
  }

  void onTapChangeCatalog(LocalCatalog catalog) {
    setState(
      () {
        currentCatalog = catalog;
        if (currentCatalog.listData.isEmpty) {
          listStocks = Future.value([]);
        } else {
          listStocks = dataCenterService
              .getStocksModelsFromStockCodes(currentCatalog.listData);
        }
      },
    );
  }

  void addCatalog() async {
    var res = await CreateCatalogISheet(savedCatalog)
        .show(context, CreateCatalogSheet(savedCatalog: savedCatalog));
    if (res.runtimeType == BackCmd && res?.data != null) {
      setState(
        () {
          localStorageService.putSavedCatalog(savedCatalog);
          currentCatalog = savedCatalog.catalogs.last;
          listStocks = Future.value([]);
        },
      );
    }
  }
}

class BottomAddStock extends StatefulWidget {
  final LocalCatalog localCatalog;

  const BottomAddStock({Key? key, required this.localCatalog})
      : super(key: key);

  @override
  State<BottomAddStock> createState() => _BottomAddStockState();
}

class _BottomAddStockState extends State<BottomAddStock> {
  final TextEditingController search = TextEditingController();
  final DataCenterService dataCenterService = DataCenterService();

  StreamController<List<Stock>> listStockController =
      StreamController<List<Stock>>.broadcast();

  Future<void> getHistory(String code) async {
    try {
      final list = dataCenterService.searchStocksBySym(code);
      listStockController.sink.add(list);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: themeMode.isLight
                ? AppColors.light_bg
                : AppColors.text_black_1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).add_stock,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w700)),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: themeMode.isLight
                            ? const Color.fromRGBO(245, 248, 255, 1)
                            : AppColors.neutral_03,
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(
                      Icons.clear,
                      size: 18,
                      color: AppColors.dark_bg,
                    ),
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 1,
              color: AppColors.neutral_05,
              height: 32,
            ),
            AppTextField(
              border: InputBorder.none,
              controller: search,
              onChanged: (value) {
                getHistory(value);
              },
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(AppImages.search_appbar_icon),
              ),
              hintText: S.of(context).Search_by_stock_code,
            ),
            Expanded(
              child: StreamBuilder<List<Stock>>(
                  stream: listStockController.stream,
                  initialData: dataCenterService.listAllStock,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var list = snapshot.data;
                      return ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return StockWidgetChart(
                              key: ObjectKey(list[index]),
                              stockModel: list[index],
                              onChanged: (value) {
                                if (value &&
                                    !widget.localCatalog.listData
                                        .contains(list[index].stockCode)) {
                                  widget.localCatalog.listData
                                      .add(list[index].stockCode);
                                } else if (!value &&
                                    widget.localCatalog.listData
                                        .contains(list[index].stockCode)) {
                                  widget.localCatalog.listData
                                      .remove(list[index].stockCode);
                                }
                              },
                              initSelect: widget.localCatalog.listData
                                  .contains(list[index].stockCode),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1,
                              height: 0,
                              color: themeMode.isLight
                                  ? const Color.fromRGBO(245, 248, 255, 1)
                                  : AppColors.neutral_03,
                            );
                          },
                          itemCount: list!.length);
                    }
                    return const SizedBox();
                  }),
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       widget.localCatalog.setStockList = stockSelect;
            //       Navigator.of(context).pop(widget.localCatalog);
            //     },
            //     child: const Text('Thêm vào danh mục'),
            //   ),
            // ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
          ],
        ),
      ),
    );
  }
}
