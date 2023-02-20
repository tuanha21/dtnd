import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_confirm_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_fail_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_success_sheet.dart';
import 'package:flutter/material.dart';

class OrderSuccessCmd extends NextCmd {
  const OrderSuccessCmd([super.data]);
}

class OrderFailCmd extends NextCmd {
  const OrderFailCmd([super.data]);
}

abstract class IStockOrderSheet extends ISheet {
  final StockModel stockModel;
  IStockOrderSheet(this.stockModel);
}

class StockOrderISheet extends IStockOrderSheet {
  StockOrderISheet(super.stockModel);

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([dynamic cmd]) => StockOrderConfirmISheet(stockModel);

  @override
  Widget? backWidget([cmd]) => null;

  @override
  Widget? nextWidget([cmd]) => StockOrderConfirmSheet(
        stockModel: stockModel,
        orderData: cmd!.data,
      );

  @override
  Future<void>? onResultBack([dynamic cmd]) => null;

  @override
  Future<void>? onResultNext([dynamic cmd]) => null;
}

class StockOrderConfirmISheet extends IStockOrderSheet {
  StockOrderConfirmISheet(super.stockModel);

  @override
  ISheet? back([dynamic cmd]) => StockOrderISheet(stockModel);

  @override
  ISheet? next([UserCmd? cmd]) {
    if (cmd is OrderSuccessCmd) {
      return StockOrderSuccessISheet(stockModel);
    } else {
      return StockOrderFailISheet(stockModel);
    }
  }

  @override
  Widget? backWidget([cmd]) => StockOrderSheet(
        stockModel: stockModel,
        orderData: cmd!.data,
      );

  @override
  Widget? nextWidget([UserCmd? cmd]) {
    if (cmd is OrderSuccessCmd) {
      return const StockOrderSuccessSheet();
    } else {
      return StockOrderFailSheet(rc: cmd!.data as int);
    }
  }

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
}

class StockOrderSuccessISheet extends IStockOrderSheet {
  StockOrderSuccessISheet(super.stockModel);

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([dynamic cmd]) => StockOrderISheet(stockModel);

  @override
  Widget? backWidget([cmd]) => StockOrderSheet(
        stockModel: stockModel,
        orderData: cmd!.data,
      );

  @override
  Widget? nextWidget([cmd]) => StockOrderSheet(
        stockModel: stockModel,
        orderData: null,
      );

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
}

class StockOrderFailISheet extends IStockOrderSheet {
  StockOrderFailISheet(super.stockModel);

  @override
  ISheet? back([dynamic cmd]) => StockOrderISheet(stockModel);

  @override
  ISheet? next([dynamic cmd]) => null;

  @override
  Widget? backWidget([cmd]) => StockOrderSheet(
        stockModel: stockModel,
        orderData: cmd!.data,
      );

  @override
  Widget? nextWidget([cmd]) => null;

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
}

class BusinessInformationISheet extends IStockOrderSheet {
  BusinessInformationISheet(super.stockModel);

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([dynamic cmd]) => null;

  @override
  Widget? backWidget([cmd]) => null;

  @override
  Widget? nextWidget([cmd]) => null;

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
}
