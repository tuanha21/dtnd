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
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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

  late Future<List<StockModel>> listStocks;

  late String user;

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
      if (currentCatalog.stocks.isNotEmpty) {
        listStocks = dataCenterService
            .getStockModelsFromStockCodes(currentCatalog.stocks);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: rowCatalog(),
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: savedCatalog.catalogs.isNotEmpty,
          child: GestureDetector(
            onTap: () {
              showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => const BottomAddStock());
            },
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
                    'Thêm mã',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.primary_01,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
        )
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
                onLongPress: () async {
                  var cmd = await CatalogOptionsISheet(savedCatalog, catalog)
                      .show(
                          context,
                          CatalogOptionsSheet(
                              savedCatalog: savedCatalog, catalog: catalog));
                  // if (cmd.runtimeType == NextCmd) {
                  //   setState(() {});
                  // }
                  setState(() {});
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
          ),
        ],
      ),
    );
  }

  void addCatalog() async {
    var res = await CreateCatalogISheet(savedCatalog)
        .show(context, CreateCatalogSheet(savedCatalog: savedCatalog));
    if (res.runtimeType == BackCmd) {
      setState(() {
        localStorageService.putSavedCatalog(savedCatalog);
        currentCatalog = savedCatalog.catalogs.last;
      });
    }
  }
}

class BottomAddStock extends StatefulWidget {
  const BottomAddStock({Key? key}) : super(key: key);

  @override
  State<BottomAddStock> createState() => _BottomAddStockState();
}

class _BottomAddStockState extends State<BottomAddStock> {
  final TextEditingController search = TextEditingController();
  final IDataCenterService dataCenterService = DataCenterService();


  @override
  void initState() {
    dataCenterService.putSearchHistory("ACB");
    super.initState();
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
                Text('Thêm danh mục theo dõi',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w700)),
                GestureDetector(
                  onTap: (){
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
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(AppImages.search_appbar_icon),
              ),
              hintText: 'Tìm theo mã cổ phiếu, tên công ty',
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
          ],
        ),
      ),
    );
  }
}
