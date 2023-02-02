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
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    initCatalog();
  }

  void initCatalog() {
    savedCatalog = localStorageService.getSavedCatalog(userService.token!.user);
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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    var res = await CreateCatalogISheet(savedCatalog).show(
                        context,
                        CreateCatalogSheet(savedCatalog: savedCatalog));
                    if (res.runtimeType == BackCmd) {
                      setState(() {
                        localStorageService.putSavedCatalog(savedCatalog);
                        currentCatalog = savedCatalog.catalogs.last;
                      });
                    }
                  },
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
                  children: List<Widget>.generate(savedCatalog.catalogs.length,
                      (index) {
                    var catalog = savedCatalog.catalogs[index];
                    return GestureDetector(
                      onLongPress: () async {
                        var cmd =
                            await CatalogOptionsISheet(savedCatalog, catalog)
                                .show(
                                    context,
                                    CatalogOptionsSheet(
                                        savedCatalog: savedCatalog,
                                        catalog: catalog));
                        if (cmd.runtimeType == NextCmd) {
                          setState(() {});
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            right:
                                index == savedCatalog.catalogs.length ? 0 : 10),
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
          ),
        ),
      ],
    );
  }
}
