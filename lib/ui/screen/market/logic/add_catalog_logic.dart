import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/ui_model/dialog.dart';
import 'package:dtnd/=models=/ui_model/overlay.dart';
import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:dtnd/ui/screen/market/logic/cmd.dart';
import 'package:dtnd/ui/screen/market/widget/sheet/catalog_options_sheet.dart';
import 'package:dtnd/ui/screen/market/widget/sheet/delete_catalog_dialog.dart';
import 'package:dtnd/ui/screen/market/widget/sheet/rename_catalog_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/ui_model/user_cmd.dart';
import '../../../../utilities/logger.dart';
import '../../stock_detail/sheet/AddStockCatalog.dart';

class CreateCatalogISheet extends ISheet {
  const CreateCatalogISheet(this.savedCatalog, {this.stock});

  final SavedCatalog savedCatalog;
  final String? stock;

  @override
  IOverlay? back([cmd]) {
    if (kDebugMode) {
      print('back ${cmd?.data}');
    }
    if (cmd is BackCmd) {
      /// back chở về màn chọn danh mục
      if (cmd.data is SavedCatalog) {
        return AddCatalogISheet(stock: stock);
      }
      if (cmd.data is BackCmd) {
        return AddCatalogISheet(stock: stock);
      }
      return null;
    }
    return null;
  }

  @override
  Widget? backWidget([cmd]) {
    if (kDebugMode) {
      print('backWidget $cmd');
    }
    if (cmd is BackCmd) {
      /// chở về màn chọn danh mục ở màn chi tiết mã
      if (cmd.data is BackCmd) {
        return AddCatalogSheet(stock: stock);
      }
      if (cmd.data is SavedCatalog) {
        return AddCatalogSheet(initSavedCatalog: cmd.data!, stock: stock);
      }
      return null;
    }
    return null;
  }

  @override
  IOverlay? next([cmd]) {
    if (kDebugMode) {
      print('next $cmd');
    }
    return null;
  }

  @override
  Widget? nextWidget([cmd]) {
    if (kDebugMode) {
      print('nextWidget $cmd');
    }
    return null;
  }

  @override
  Future<void>? onResultBack([cmd]) {
    if (kDebugMode) {
      print('onResultBack ${cmd?.data}');
    }
    return null;
  }

  @override
  Future<void>? onResultNext([cmd]) {
    if (kDebugMode) {
      print('onResultNext $cmd');
    }
    return null;
  }
}

class CatalogOptionsISheet extends ISheet {
  const CatalogOptionsISheet(this.savedCatalog, this.catalog);

  final SavedCatalog savedCatalog;
  final LocalCatalog catalog;

  @override
  IOverlay? back([cmd]) {
    return null;
  }

  @override
  Widget? backWidget([cmd]) => null;

  @override
  IOverlay? next([cmd]) {
    if (cmd is DeleteCatalogCmd) {
      return DeleteCatalogIDialog(savedCatalog, catalog);
    } else if (cmd is RenameCatalogCmd) {
      return RenameCatalogISheet(savedCatalog, catalog);
    }
    return null;
  }

  @override
  Widget? nextWidget([cmd]) {
    if (cmd is DeleteCatalogCmd) {
      return DeleteCatalogDialog(savedCatalog: savedCatalog, catalog: catalog);
    } else if (cmd is RenameCatalogCmd) {
      return RenameCatalogSheet(savedCatalog: savedCatalog, catalog: catalog);
    }
    return null;
  }

  @override
  Future<void>? onResultBack([cmd]) {
    return null;
  }

  @override
  Future<void>? onResultNext([cmd]) => null;
}

class DeleteCatalogIDialog extends ISheet {
  const DeleteCatalogIDialog(this.savedCatalog, this.catalog);

  final SavedCatalog savedCatalog;
  final LocalCatalog catalog;

  @override
  IOverlay? back([cmd]) => CatalogOptionsISheet(savedCatalog, catalog);

  @override
  Widget? backWidget([cmd]) =>
      CatalogOptionsSheet(savedCatalog: savedCatalog, catalog: catalog);

  @override
  IOverlay? next([cmd]) => null;

  @override
  Widget? nextWidget([cmd]) => null;

  @override
  Future<void>? onResultBack([cmd]) {
    return null;
  }

  @override
  Future<void>? onResultNext([cmd]) {
    return null;
  }
}

class RenameCatalogISheet extends ISheet {
  const RenameCatalogISheet(this.savedCatalog, this.catalog);

  final SavedCatalog savedCatalog;
  final LocalCatalog catalog;

  @override
  IOverlay? back([cmd]) {
    return CatalogOptionsISheet(savedCatalog, catalog);
  }

  @override
  Widget? backWidget([cmd]) {
    return CatalogOptionsSheet(savedCatalog: savedCatalog, catalog: catalog);
  }

  @override
  IOverlay? next([cmd]) => null;

  @override
  Widget? nextWidget([cmd]) => null;

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
}
