import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_flow.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import 'package:flutter/material.dart';

class StockModelUtil {
  static openSheet(BuildContext context, {StockModel? model}) async {
    if (model != null) {
      StockOrderISheet(null).show(
          context,
          StockOrderSheet(
            stockModel: model,
            orderData: null,
          ));
      return;
    }
    final IDataCenterService dataCenterService = DataCenterService();
    final list = await dataCenterService.getStocksModelsFromStockCodes(["AAA"]);
    final StockModel? aaa;
    if (list?.isNotEmpty ?? false) {
      aaa = list!.first;
    } else {
      aaa = null;
    }
    if (context.mounted) {
      StockOrderISheet(null).show(
          context,
          StockOrderSheet(
            stockModel: aaa,
            orderData: null,
          ));
    }
  }
}
