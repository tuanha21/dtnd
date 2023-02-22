import 'dart:async';
import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/icon/active_button.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/stock_vol.dart';

class TabMatchedDetail extends StatefulWidget {
  const TabMatchedDetail({
    super.key,
    required this.stockModel,
  });

  final StockModel stockModel;

  @override
  State<TabMatchedDetail> createState() => _TabMatchedDetailState();
}

class _TabMatchedDetailState extends State<TabMatchedDetail> {
  final IDataCenterService dataCenterService = DataCenterService();

  bool byTime = false;

  num maxVolumn = 0;

  StreamController<List<IndayMatchedOrder>> listMatchedOrder =
      StreamController<List<IndayMatchedOrder>>.broadcast();

  StreamController<List<StockMatch>> listMatchedStock =
      StreamController<List<StockMatch>>.broadcast();

  @override
  void initState() {
    super.initState();
    getIndayMatchedStock();
  }

  void getIndayMatchedOrders() {
    dataCenterService
        .getIndayMatchedOrders(widget.stockModel.stock.stockCode)
        .then((list) {
      listMatchedOrder.sink.add(list);
    });
  }

  void getIndayMatchedStock() {
    dataCenterService
        .getListStockMatch(widget.stockModel.stock.stockCode)
        .then((list) {
      listMatchedStock.sink.add(list);
    });
  }

  void changeMode(bool newValue) {
    if (byTime != newValue) {
      setState(() {
        byTime = newValue;
        if (byTime) {
          getIndayMatchedOrders();
        } else {
          getIndayMatchedStock();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                byTime
                    ? S.of(context).matched_order_by_time
                    : S.of(context).matched_order_by_price_step,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ActiveButton(
                    size: 12,
                    icon: AppImages.timer,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    isActive: () => byTime,
                    onActive: () => changeMode(true),
                    activeButtonColor: (themeMode) => AppColors.primary_01,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  const SizedBox(width: 10),
                  ActiveButton(
                    size: 12,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    icon: AppImages.chart,
                    isActive: () => !byTime,
                    onActive: () => changeMode(false),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                ],
              )
            ],
          ),
        ),
        Visibility(visible: byTime, child: const _TabMatchedDetailHeader()),
        byTime ? orderWidget() : stockMatchWidget(),
      ],
    );
  }

  Widget orderWidget() {
    return Expanded(
      child: StreamBuilder<List<IndayMatchedOrder>>(
          stream: listMatchedOrder.stream,
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              var list = snapshot.data!;
              widget.stockModel.updateListMatchedOrder(list.reversed.toList());
              maxVolumn = widget.stockModel.maxVolumnMatchedOrder;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  var element = list[index];
                  return _TabMatchedDetailRow(
                    data: element,
                    maxVolumn: maxVolumn,
                    colorFunct: widget.stockModel.stockData.getPriceColor,
                  );
                },
              );
            }
            return const SizedBox();
          }),
    );
  }

  Widget stockMatchWidget() {
    return Expanded(
      child: StreamBuilder<List<StockMatch>>(
          stream: listMatchedStock.stream,
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              var list = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  var element = list[index];
                  return _TabMatchStock(
                    stockMatch: element,
                    colorFunct: widget.stockModel.stockData.getPriceColor,
                  );
                },
              );
            }
            return const SizedBox();
          }),
    );
  }
}

class _TabMatchedDetailRow extends StatelessWidget {
  const _TabMatchedDetailRow({
    required this.data,
    required this.colorFunct,
    required this.maxVolumn,
  });

  final IndayMatchedOrder data;
  final Function colorFunct;
  final num maxVolumn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.labelMedium!,
        child: Row(
          children: [
            Expanded(
                child: Text(
              data.time,
              textAlign: TextAlign.left,
            )),
            Expanded(
                child: Text(
              NumUtils.formatInteger10(data.matchVolume),
              textAlign: TextAlign.right,
            )),
            Expanded(
                child: Text(
              NumUtils.formatDouble(data.matchPrice),
              style: TextStyle(color: colorFunct.call(data.matchPrice)),
              textAlign: TextAlign.right,
            )),
            Expanded(
                child: Text(
              "${NumUtils.formatDouble(data.priceChange)}%",
              style: TextStyle(color: colorFunct.call(data.matchPrice)),
              textAlign: TextAlign.right,
            )),
          ],
        ),
      ),
    );
  }
}

class _TabMatchedDetailHeader extends StatelessWidget {
  const _TabMatchedDetailHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.labelMedium!,
        child: Row(
          children: [
            Expanded(child: Text(S.of(context).time)),
            Expanded(
                child: Text(
              S.of(context).matched_vol,
              textAlign: TextAlign.right,
            )),
            Expanded(
                child: Text(
              S.of(context).matched_price,
              textAlign: TextAlign.right,
            )),
            Expanded(
                child: Text(
              S.of(context).vol_analysis,
              textAlign: TextAlign.right,
            )),
          ],
        ),
      ),
    );
  }
}

class _TabMatchStock extends StatelessWidget {
  final StockMatch stockMatch;
  final Function colorFunct;

  const _TabMatchStock(
      {Key? key, required this.stockMatch, required this.colorFunct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(children: [
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Text('${stockMatch.matchPrice}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    color: colorFunct.call(stockMatch.matchPrice))),
          ),
          const SizedBox(width: 10),
          Expanded(
              flex: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Row(children: [
                  Expanded(
                      flex: stockMatch.buyActiveQtty?.toInt() ?? 0,
                      child: Container(
                          decoration:
                              const BoxDecoration(color: AppColors.semantic_01),
                          height: 16)),
                  Expanded(
                      flex: stockMatch.sellActiveQtty?.toInt() ?? 0,
                      child:
                          Container(color: AppColors.semantic_03, height: 16)),
                  Expanded(
                      flex: stockMatch.noneActiveQtty?.toInt() ?? 0,
                      child: Container(
                          decoration:
                              const BoxDecoration(color: AppColors.neutral_03),
                          height: 16))
                ]),
              )),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(NumUtils.formatInteger(stockMatch.totalVol),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.neutral_03)),
            ),
          ),
          const SizedBox(width: 16),
        ]));
  }
}
