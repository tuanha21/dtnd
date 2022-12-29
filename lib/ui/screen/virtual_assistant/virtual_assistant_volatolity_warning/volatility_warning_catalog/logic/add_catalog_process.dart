import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/local/volatility_warning_catalog.dart';
import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_volatolity_warning/volatility_warning_catalog/sheet/volatility_warning_change_stock_figure_sheet.dart';
import 'package:flutter/material.dart';

class AddCatalogISheet extends ISheet {
  const AddCatalogISheet(this.savedCatalog);
  final SavedCatalog<VolatilityWarningCatalogStock> savedCatalog;
  @override
  ISheet? back([data]) => null;

  @override
  ISheet? next([data]) => const ChangeCatalogFigureISheet();

  @override
  Widget? backWidget([data]) => null;

  @override
  Widget? nextWidget([data]) => VolatilityWarningChangeStockFigureSheet(
        stock: data,
      );

  @override
  Future<void>? onResultBack([data]) => null;

  @override
  Future<void>? onResultNext([data]) => null;
}

class ChangeCatalogFigureISheet extends ISheet {
  const ChangeCatalogFigureISheet();
  @override
  ISheet? back([data]) => null;

  @override
  ISheet? next([data]) => null;

  @override
  Widget? backWidget([data]) => null;

  @override
  Widget? nextWidget([data]) => VolatilityWarningChangeStockFigureSheet(
        stock: data,
      );

  @override
  Future<void>? onResultBack([dynamic data]) => null;

  @override
  Future<void>? onResultNext([dynamic data]) => null;
}
