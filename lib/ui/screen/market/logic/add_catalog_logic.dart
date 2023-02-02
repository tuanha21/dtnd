import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/ui_model/dialog.dart';
import 'package:dtnd/=models=/ui_model/overlay.dart';
import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:dtnd/ui/screen/market/logic/cmd.dart';
import 'package:dtnd/ui/screen/market/widget/sheet/catalog_options_sheet.dart';
import 'package:dtnd/ui/screen/market/widget/sheet/delete_catalog_dialog.dart';
import 'package:dtnd/ui/screen/market/widget/sheet/rename_catalog_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../utilities/logger.dart';



class CreateCatalogISheet extends ISheet {
  const CreateCatalogISheet(this.savedCatalog);

  final SavedCatalog savedCatalog;

  @override
  IOverlay? back([cmd]) => null;

  @override
  Widget? backWidget([cmd]) => null;

  @override
  IOverlay? next([cmd]) => null;

  @override
  Widget? nextWidget([cmd]) => null;

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
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

class DeleteCatalogIDialog extends IDialog {
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
