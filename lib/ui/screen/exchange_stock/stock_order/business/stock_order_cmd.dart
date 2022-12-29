import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_confirm_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_success_sheet.dart';
import 'package:flutter/material.dart';

abstract class IStockOrderSheet extends ISheet {
  final StockModel stockModel;
  IStockOrderSheet(this.stockModel);
}

class StockOrderISheet extends IStockOrderSheet {
  StockOrderISheet(super.stockModel);

  @override
  ISheet? back([dynamic data]) => null;

  @override
  ISheet? next([dynamic data]) => StockOrderConfirmISheet(stockModel);

  @override
  Widget? backWidget([data]) => null;

  @override
  Widget? nextWidget([data]) => StockOrderConfirmSheet(
        stockModel: stockModel,
        orderData: data,
      );

  @override
  Future<void>? onResultBack([dynamic data]) => null;

  @override
  Future<void>? onResultNext([dynamic data]) => null;
}

class StockOrderConfirmISheet extends IStockOrderSheet {
  StockOrderConfirmISheet(super.stockModel);

  @override
  ISheet? back([dynamic data]) => StockOrderISheet(stockModel);

  @override
  ISheet? next([dynamic data]) => StockOrderSuccessISheet(stockModel);

  @override
  Widget? backWidget([data]) => StockOrderSheet(
        stockModel: stockModel,
        orderData: data,
      );

  @override
  Widget? nextWidget([data]) => const StockOrderSuccessSheet();

  @override
  Future<void>? onResultBack([data]) => null;

  @override
  Future<void>? onResultNext([data]) => null;
}

class StockOrderSuccessISheet extends IStockOrderSheet {
  StockOrderSuccessISheet(super.stockModel);

  @override
  ISheet? back([dynamic data]) => null;

  @override
  ISheet? next([dynamic data]) => StockOrderISheet(stockModel);

  @override
  Widget? backWidget([data]) => StockOrderSheet(
        stockModel: stockModel,
        orderData: data,
      );

  @override
  Widget? nextWidget([data]) => StockOrderSheet(
        stockModel: stockModel,
        orderData: null,
      );

  @override
  Future<void>? onResultBack([data]) => null;

  @override
  Future<void>? onResultNext([data]) => null;
}
