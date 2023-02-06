import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/input/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../../utilities/deboncer.dart';
import '../../../../../utilities/logger.dart';
import '../../../../theme/app_textstyle.dart';
import '../../../../widget/icon/stock_icon.dart';
import '../../logic/add_catalog_logic.dart';
import '../sheet/catalog_options_sheet.dart';
import '../sheet/create_catalog_sheet.dart';

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
  late SavedCatalog savedCatalog;

  late LocalCatalog currentCatalog;

  late Future<List<StockModel>> listStocks = Future.value([]);

  late String user;

  int get currentCatalogIndex => savedCatalog.catalogs
      .indexWhere((element) => element.name == currentCatalog.name);

  @override
  void initState() {
    super.initState();
    initCatalog();
  }

  void initCatalog() {
    if (userService.token == null) {
      user = "default";
    } else {
      user = userService.token!.user;
    }
    savedCatalog = localStorageService.getSavedCatalog(user);
    if (savedCatalog.catalogs.isNotEmpty) {
      currentCatalog = savedCatalog.catalogs.first;
      if (currentCatalog.listStock.isNotEmpty) {
        listStocks = dataCenterService
            .getStockModelsFromStockCodes(currentCatalog.listStock);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(alignment: Alignment.centerLeft, child: rowCatalog()),
        const SizedBox(height: 10),
        Visibility(
          visible: savedCatalog.catalogs.isNotEmpty,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.neutral_06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      if (currentCatalog.listStock.isNotEmpty) {
                        listStocks =
                            dataCenterService.getStockModelsFromStockCodes(
                                currentCatalog.listStock);
                      } else {
                        listStocks = Future.value([]);
                      }
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.add_square,
                        color: AppColors.primary_01,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Thêm mã',
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
                    await updateCatalog(currentCatalog);
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
                        'Chỉnh sửa',
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
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<StockModel>>(
            future: listStocks,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var list = snapshot.data;
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.25,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                // An action can be bigger than the others.
                                onPressed: (BuildContext context) {
                                  setState(() {
                                    currentCatalog.listStock
                                        .remove(list![index].stock.stockCode);
                                    savedCatalog.catalogs[currentCatalogIndex] =
                                        currentCatalog;
                                    localStorageService
                                        .putSavedCatalog(savedCatalog);
                                    if (currentCatalog.listStock.isNotEmpty) {
                                      listStocks = dataCenterService
                                          .getStockModelsFromStockCodes(
                                              currentCatalog.listStock);
                                    } else {
                                      listStocks = Future.value([]);
                                    }
                                  });
                                },
                                backgroundColor: AppColors.semantic_03,
                                foregroundColor: Colors.white,
                                icon: Icons.delete_outline,
                                spacing: 0,
                                label: 'Xóa mã',
                              ),
                            ],
                          ),
                          child: StockWidgetChart(stockModel: list![index]));
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 2,
                        height: 0,
                        color: Color.fromRGBO(245, 248, 255, 1),
                      );
                    },
                    itemCount: list!.length);
              }
              return const SizedBox();
            })
      ],
    );
  }

  Widget rowCatalog() {
    if (savedCatalog.catalogs.isEmpty) {
      return GestureDetector(
        onTap: addCatalog,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.neutral_06),
          child: Row(
            children: [
              SvgPicture.asset(
                AppImages.add_square,
                color: AppColors.primary_01,
              ),
              const SizedBox(width: 8),
              Text(
                'Tạo danh mục theo dõi',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.primary_01, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: addCatalog,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(236, 241, 253, 1),
                  borderRadius: BorderRadius.circular(4)),
              height: 28,
              width: 28,
              alignment: Alignment.center,
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(width: 4),
          Row(
            children:
                List<Widget>.generate(savedCatalog.catalogs.length, (index) {
              var catalog = savedCatalog.catalogs[index];
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
                      borderRadius: BorderRadius.circular(4)),
                  height: 28,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  child: Text(catalog.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.light_bg)),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Future<void> updateCatalog(LocalCatalog catalog) async {
    await CatalogOptionsISheet(savedCatalog, catalog).show(context,
        CatalogOptionsSheet(savedCatalog: savedCatalog, catalog: catalog));
    setState(() {});
  }

  void onTapChangeCatalog(LocalCatalog catalog) {
    setState(() {
      currentCatalog = catalog;
      if (currentCatalog.listStock.isEmpty) {
        listStocks = Future.value([]);
      } else {
        listStocks = dataCenterService
            .getStockModelsFromStockCodes(currentCatalog.listStock);
      }
    });
  }

  void addCatalog() async {
    var res = await CreateCatalogISheet(savedCatalog)
        .show(context, CreateCatalogSheet(savedCatalog: savedCatalog));
    if (res.runtimeType == BackCmd) {
      setState(() {
        localStorageService.putSavedCatalog(savedCatalog);
        currentCatalog = savedCatalog.catalogs.last;
        listStocks = Future.value([]);
      });
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
  final IDataCenterService dataCenterService = DataCenterService();

  StreamController<List<StockModel>> listStockController =
      StreamController<List<StockModel>>.broadcast();

  final _debouncer = Debouncer(milliseconds: 500);

  Future<void> getHistory(String code) async {
    try {
      var list = dataCenterService.searchStocksBySym(code);
      var listStockModel = await dataCenterService
          .getStockModelsFromStockCodes(list.map((e) => e.stockCode).toList());
      listStockController.sink.add(listStockModel);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: AppColors.light_bg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Thêm mã',
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
                        color: const Color.fromRGBO(245, 248, 255, 1),
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
                _debouncer.run(() {
                  getHistory(value);
                });
              },
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(AppImages.search_appbar_icon),
              ),
              hintText: 'Tìm theo mã cổ phiếu, tên công ty',
            ),
            Expanded(
              child: StreamBuilder<List<StockModel>>(
                  stream: listStockController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var list = snapshot.data;
                      return ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return StockWidgetChart(
                              key: ObjectKey(list![index]),
                              stockModel: list[index],
                              onChanged: (value) {
                                if (value &&
                                    !widget.localCatalog.listStock.contains(
                                        list[index].stock.stockCode)) {
                                  widget.localCatalog.listStock
                                      .add(list[index].stock.stockCode);
                                } else if (!value &&
                                    widget.localCatalog.listStock.contains(
                                        list[index].stock.stockCode)) {
                                  widget.localCatalog.listStock
                                      .remove(list[index].stock.stockCode);
                                }
                              },
                              initSelect: widget.localCatalog.listStock
                                  .contains(list[index].stock.stockCode),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 2,
                              height: 0,
                              color: Color.fromRGBO(245, 248, 255, 1),
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

class StockWidgetChart extends StatefulWidget {
  final StockModel stockModel;
  final bool initSelect;
  final ValueChanged<bool>? onChanged;

  const StockWidgetChart(
      {Key? key,
      required this.stockModel,
      this.onChanged,
      this.initSelect = false})
      : super(key: key);

  @override
  State<StockWidgetChart> createState() => _StockWidgetChartState();
}

class _StockWidgetChartState extends State<StockWidgetChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22.5),
      decoration: const BoxDecoration(color: AppColors.light_bg),
      child: Row(
        children: [
          StockIcon(
            stockCode: widget.stockModel.stock.stockCode,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.stockModel.stock.stockCode,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.stockModel.stock.nameShort ?? "",
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${widget.stockModel.stockData.lastPrice.value}',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: widget.stockModel.stockData.color),
                ),
                Text(
                  '(-${widget.stockModel.stockData.changePc.value}%)',
                  style: AppTextStyle.labelMedium_12.copyWith(
                      color: widget.stockModel.stockData.color, fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          AddStockIcon(initAdd: widget.initSelect, onChanged: widget.onChanged)
        ],
      ),
    );
  }
}

class AddStockIcon extends StatefulWidget {
  final bool initAdd;
  final ValueChanged<bool>? onChanged;

  const AddStockIcon({Key? key, required this.initAdd, this.onChanged})
      : super(key: key);

  @override
  State<AddStockIcon> createState() => _AddStockIconState();
}

class _AddStockIconState extends State<AddStockIcon> {
  bool isAdd = false;

  @override
  void initState() {
    isAdd = widget.initAdd;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.onChanged != null,
        child: GestureDetector(
            onTap: () {
              setState(() {
                isAdd = !isAdd;
                widget.onChanged?.call(isAdd);
              });
            },
            child: Icon(
              isAdd ? Icons.check_circle : Icons.add_circle,
              color: isAdd ? AppColors.primary_01 : AppColors.neutral_04,
            )));
  }
}
