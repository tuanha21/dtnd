import 'package:dtnd/=models=/ui_model/overlay.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../=models=/local/saved_catalog.dart';
import '../../../../=models=/ui_model/sheet.dart';
import '../../../../data/i_local_storage_service.dart';
import '../../../../data/i_user_service.dart';
import '../../../../data/implementations/data_center_service.dart';
import '../../../../data/implementations/local_storage_service.dart';
import '../../../../data/implementations/user_service.dart';
import '../../../widget/app_snack_bar.dart';
import '../../../widget/icon/sheet_header.dart';
import '../../market/logic/add_catalog_logic.dart';
import '../../market/widget/sheet/create_catalog_sheet.dart';

class AddCatalogISheet extends ISheet {
  final String? stock;

  AddCatalogISheet({this.stock});

  @override
  IOverlay? back([UserCmd? cmd]) {
    return null;
  }

  @override
  Widget? backWidget([UserCmd? cmd]) {
    return null;
  }

  @override
  IOverlay? next([UserCmd? cmd]) {
    if (cmd is NextCmd) {
      var data = cmd.data as SavedCatalog;
      return CreateCatalogISheet(data, stock: stock);
    }
    return null;
  }

  @override
  Widget? nextWidget([UserCmd? cmd]) {
    if (cmd is NextCmd) {
      var data = cmd.data as SavedCatalog;
      return CreateCatalogSheet(savedCatalog: data, isBack: true);
    }
    return null;
  }

  @override
  Future<void>? onResultBack([UserCmd? cmd]) {
    return null;
  }

  @override
  Future<void>? onResultNext([UserCmd? cmd]) {
    return null;
  }
}

class AddCatalogSheet extends StatefulWidget {
  final SavedCatalog? initSavedCatalog;
  final String? stock;

  const AddCatalogSheet({Key? key, this.initSavedCatalog, this.stock})
      : super(key: key);

  @override
  State<AddCatalogSheet> createState() => _AddCatalogSheetState();
}

class _AddCatalogSheetState extends State<AddCatalogSheet> {
  final DataCenterService dataCenterService = DataCenterService();
  final ILocalStorageService localStorageService = LocalStorageService();
  final IUserService userService = UserService();

  late SavedCatalog savedCatalog;

  late String user;

  @override
  void initState() {
    if (widget.initSavedCatalog != null) {
      savedCatalog = widget.initSavedCatalog!;
      localStorageService.putSavedCatalog(savedCatalog);
      return;
    }

    if (userService.token.value == null) {
      user = "default";
    } else {
      user = userService.token.value!.user;
    }
    savedCatalog = localStorageService.getSavedCatalog(user);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: AppColors.light_bg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetHeader(title: "Chọn danh mục"),
          savedCatalog.catalogs.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var catalog = savedCatalog.catalogs[index];
                    return _RowButton(
                      tittle: catalog.name,
                      onTap: () {
                        if (!savedCatalog.catalogs[index].listData
                            .contains(widget.stock!)) {
                          catalog.listData.add(widget.stock!);
                          savedCatalog.catalogs[index] = catalog;
                          localStorageService.putSavedCatalog(savedCatalog);
                          Navigator.pop(context);
                          AppSnackBar.showInfo(context,
                              message: "Thêm mã thành công");
                        } else {
                          Navigator.pop(context);
                          AppSnackBar.showInfo(context,
                              message: "Mã đã thêm trong danh mục");
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: savedCatalog.catalogs.length)
              : _RowButton(
                  tittle: "Thêm danh mục",
                  onTap: () {
                    Navigator.pop(context, NextCmd(savedCatalog));
                  },
                  leading: SvgPicture.asset(AppImages.archive_add))
        ],
      ),
    );
  }
}

class _RowButton extends StatelessWidget {
  final String tittle;
  final Widget? leading;
  final Function()? onTap;

  const _RowButton({Key? key, required this.tittle, this.leading, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: ListTile(
        leading: leading,
        title: Text(tittle),
        onTap: onTap,
        trailing: const Icon(Icons.chevron_right_outlined),
      ),
    );
  }
}
