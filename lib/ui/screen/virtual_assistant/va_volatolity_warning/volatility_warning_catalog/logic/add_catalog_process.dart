import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/volatility_warning_catalog/sheet/volatility_warning_catalog_sheet.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/volatility_warning_catalog/sheet/volatility_warning_change_stock_figure_sheet.dart';
import 'package:dtnd/ui/screen/market/widget/sheet/create_catalog_sheet.dart';
import 'package:flutter/material.dart';

class CreateCatalogCmd extends NextCmd {}

class AddCatalogISheet extends ISheet {
  const AddCatalogISheet(this.savedCatalog);
  final SavedCatalog savedCatalog;
  @override
  ISheet? back([cmd]) => null;

  @override
  ISheet? next([cmd]) {
    return ChangeCatalogFigureISheet(savedCatalog);
  }

  @override
  Widget? backWidget([cmd]) => null;

  @override
  Widget? nextWidget([cmd]) {
    if (cmd is CreateCatalogCmd) {
      return CreateCatalogSheet(
        savedCatalog: savedCatalog,
      );
    }
    return VolatilityWarningChangeStockFigureSheet(
      stock: cmd!.data,
    );
  }

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
}

class ChangeCatalogFigureISheet extends ISheet {
  const ChangeCatalogFigureISheet(this.savedCatalog);
  final SavedCatalog savedCatalog;
  @override
  ISheet? back([cmd]) => AddCatalogISheet(savedCatalog);

  @override
  ISheet? next([cmd]) => null;

  @override
  Widget? backWidget([cmd]) =>
      VolatilityWarningCatalogSheet(savedCatalog: savedCatalog);

  @override
  Widget? nextWidget([cmd]) => VolatilityWarningChangeStockFigureSheet(
        stock: cmd!.data,
      );

  @override
  Future<void>? onResultBack([dynamic cmd]) => null;

  @override
  Future<void>? onResultNext([dynamic cmd]) => null;
}
