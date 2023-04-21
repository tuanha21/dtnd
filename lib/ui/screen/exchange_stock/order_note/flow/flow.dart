import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_flow.dart'
    show OrderSuccessCmd, StockOrderISheet;
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/cancel_order_success_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/change_order_success_sheet.dart';
import 'package:flutter/material.dart';

class ChangeStockOrderISheet extends ISheet {
  ChangeStockOrderISheet(this.model);
  final BaseOrderModel model;

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([UserCmd? cmd]) {
    print(cmd.runtimeType);
    if (cmd is OrderSuccessCmd) {
      print("success");
      return ChangeOrderSuccessISheet();
    }
  }

  @override
  Widget? backWidget([cmd]) => null;

  @override
  Widget? nextWidget([UserCmd? cmd]) {
    print(cmd.runtimeType);
    if (cmd is OrderSuccessCmd) {
      print("success");
      return const ChangeOrderSuccessSheet();
    }
  }

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
}

class ChangeOrderSuccessISheet extends ISheet {
  ChangeOrderSuccessISheet();

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

class CancelStockOrderISheet extends ISheet {
  CancelStockOrderISheet(this.model);
  final BaseOrderModel model;

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([UserCmd? cmd]) {
    if (cmd is OrderSuccessCmd) {
      return CancelOrderSuccessISheet();
    }
  }

  @override
  Widget? backWidget([cmd]) => null;

  @override
  Widget? nextWidget([UserCmd? cmd]) {
    if (cmd is OrderSuccessCmd) {
      return const CancelOrderSuccessSheet(
        showButton: false,
      );
    }
    return null;
  }

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
}

class CancelOrderSuccessISheet extends ISheet {
  CancelOrderSuccessISheet();

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
