import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/stock_board.dart';
import '../../../../generated/l10n.dart';

class ForeignWidget extends StatefulWidget {
  final StockModel stockModel;

  const ForeignWidget({Key? key, required this.stockModel}) : super(key: key);

  @override
  State<ForeignWidget> createState() => _ForeignWidgetState();
}

class _ForeignWidgetState extends State<ForeignWidget> {
  final INetworkService iNetworkService = NetworkService();

  late Future<StockBoard> stockBoard;

  @override
  void initState() {
    stockBoard = iNetworkService.getStockBoard(widget.stockModel.stockData.sym);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StockBoard>(
        future: stockBoard,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            var stockBoard = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Spacer(),
                      Expanded(child: Text("Mua")),
                      Expanded(child: Text("Bán")),
                      Expanded( child: Text("Mua bán ròng"))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: Text(S.of(context).volumn)),
                      Expanded(child: Text(NumUtils.formatInteger(stockBoard.fGBuyQuantity))),
                      Expanded(child: Text(NumUtils.formatInteger(stockBoard.fGSellQuantity))),
                      Expanded( child: Text(NumUtils.formatInteger(stockBoard.fGNetQuantity)))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Expanded(child: Text("Giá trị giao dịch")),
                      Expanded(child: Text(NumUtils.formatInteger(stockBoard.fGBuyValue))),
                      Expanded(child: Text(NumUtils.formatInteger(stockBoard.fGSellValue))),
                      Expanded( child: Text(NumUtils.formatInteger(stockBoard.fGNetValue)))
                    ],
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        });
  }
}
