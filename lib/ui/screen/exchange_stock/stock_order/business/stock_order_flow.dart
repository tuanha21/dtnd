import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/ui_model/dialog.dart';
import 'package:dtnd/=models=/ui_model/overlay.dart';
import 'package:dtnd/=models=/ui_model/sheet.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/cancel_order_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/cancel_order_success_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/change_order_success_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/change_stock_order_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_confirm_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_fail_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_success_dialog.dart';
import 'package:flutter/material.dart';

class OrderSuccessCmd extends NextCmd {
  const OrderSuccessCmd([super.data]);
}

class OrderFailCmd extends NextCmd {
  const OrderFailCmd([super.data]);
}

class ToChangeOrderCmd extends NextCmd {
  const ToChangeOrderCmd([super.data]);
}

class ToStockOrderCmd extends NextCmd {
  const ToStockOrderCmd([super.data]);
}

class ToCancelOrderCmd extends NextCmd {
  const ToCancelOrderCmd([super.data]);
}

abstract class IStockOrderSheet extends ISheet {
  final StockModel? stockModel;

  IStockOrderSheet(this.stockModel);
}

class StockOrderISheet extends IStockOrderSheet {
  StockOrderISheet(super.stockModel);

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([UserCmd? cmd]) {
    if (cmd is ToChangeOrderCmd) {
      return ChangeStockOrderISheet(cmd.data.first, cmd.data.last);
    } else if (cmd is ToCancelOrderCmd) {
      return CancelStockOrderISheet(cmd.data.first, cmd.data.last);
    }
    return StockOrderConfirmISheet(stockModel);
  }

  @override
  Widget? backWidget([cmd]) => null;

  @override
  Widget? nextWidget([cmd]) {
    if (cmd is ToChangeOrderCmd) {
      return ChangeStockOrderSheet(data: cmd.data.last);
    } else if (cmd is ToCancelOrderCmd) {
      return CancelStockOrderSheet(data: cmd.data.last);
    }
    return StockOrderConfirmSheet(
      orderData: cmd!.data,
    );
  }

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
  IOverlay? next([UserCmd? cmd]) {
    if (cmd is OrderSuccessCmd) {
      return StockOrderSuccessISheet(cmd.data);
    } else {
      return StockOrderFailISheet(stockModel);
    }
  }

  @override
  Widget? backWidget([cmd]) => StockOrderSheet(
        stockModel: cmd!.data.stockModel,
        orderData: cmd.data,
      );

  @override
  Widget? nextWidget([UserCmd? cmd]) {
    if (cmd is OrderSuccessCmd) {
      return StockOrderSuccessSheet(
        orderData: cmd.data,
      );
    } else {
      return StockOrderFailSheet(
        rc: cmd!.data as int,
      );
    }
  }

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
}

class ChangeStockOrderISheet extends IStockOrderSheet {
  ChangeStockOrderISheet(super.stockModel, this.model);

  final BaseOrderModel model;

  @override
  ISheet? back([dynamic cmd]) => StockOrderISheet(stockModel);

  @override
  IOverlay? next([UserCmd? cmd]) {
    if (cmd is OrderSuccessCmd) {
      return ChangeOrderSuccessISheet(stockModel);
    } else {
      return StockOrderFailISheet(stockModel);
    }
  }

  @override
  Widget? backWidget([cmd]) => StockOrderSheet(
        stockModel: stockModel,
        orderData: cmd?.data,
      );

  @override
  Widget? nextWidget([UserCmd? cmd]) {
    if (cmd is OrderSuccessCmd) {
      return const ChangeOrderSuccessSheet(
        showButton: true,
      );
    } else {
      return StockOrderFailSheet(
        rc: cmd!.data as int,
      );
    }
  }

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
}

class CancelStockOrderISheet extends IStockOrderSheet {
  CancelStockOrderISheet(super.stockModel, this.model);

  final BaseOrderModel model;

  @override
  ISheet? back([dynamic cmd]) => StockOrderISheet(stockModel);

  @override
  IOverlay? next([UserCmd? cmd]) {
    if (cmd is OrderSuccessCmd) {
      return CancelOrderSuccessISheet(stockModel);
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
      return CancelOrderSuccessSheet(
        showButton: true,
        orderData: cmd.data,
      );
    } else {
      return StockOrderFailSheet(
        rc: cmd!.data as int,
      );
    }
  }

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;
}

class StockOrderSuccessISheet extends IDialog {
  final OrderData? orderData;

  StockOrderSuccessISheet(this.orderData);

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([dynamic cmd]) => StockOrderISheet(cmd?.data.stockModel);

  @override
  Widget? backWidget([cmd]) => null;

  @override
  Widget? nextWidget([cmd]) {
    if (cmd is ToStockOrderCmd) {
      return StockOrderSheet(
        stockModel: cmd.data.stockModel,
        orderData: cmd.data,
        defaultTab: 1,
      );
    }
    return StockOrderSheet(
      stockModel: cmd?.data.stockModel,
      orderData: cmd?.data,
    );
  }

  @override
  Future<void>? onResultBack([cmd]) => null;

  @override
  Future<void>? onResultNext([cmd]) => null;

  @override
  Future<UserCmd?> onTapOutside(BuildContext context) {
    return cmd(context, ToStockOrderCmd(orderData));
  }
}

class ChangeOrderSuccessISheet extends IDialog {
  final StockModel? stockModel;

  ChangeOrderSuccessISheet(this.stockModel);

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([dynamic cmd]) => StockOrderISheet(stockModel);

  @override
  Widget? backWidget([cmd]) => null;

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

class CancelOrderSuccessISheet extends IDialog {
  final StockModel? stockModel;

  CancelOrderSuccessISheet(this.stockModel);

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([dynamic cmd]) => StockOrderISheet(stockModel);

  @override
  Widget? backWidget([cmd]) => null;

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

class StockOrderFailISheet extends IDialog {
  final StockModel? stockModel;

  StockOrderFailISheet(this.stockModel);

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([dynamic cmd]) => StockOrderISheet(stockModel);

  @override
  Widget? backWidget([cmd]) => null;

  @override
  Widget? nextWidget([cmd]) => StockOrderSheet(
        stockModel: stockModel,
        orderData: cmd!.data,
      );

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
