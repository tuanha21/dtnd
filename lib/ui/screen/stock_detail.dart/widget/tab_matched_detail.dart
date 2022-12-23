import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class TabMatchedDetail extends StatefulWidget {
  const TabMatchedDetail({
    super.key,
    required this.stockModel,
    required this.scrollController,
    required this.panelController,
  });

  final ScrollController scrollController;
  final PanelController panelController;
  final StockModel stockModel;
  @override
  State<TabMatchedDetail> createState() => _TabMatchedDetailState();
}

class _TabMatchedDetailState extends State<TabMatchedDetail> {
  final IDataCenterService dataCenterService = DataCenterService();

  bool initialized = false;

  @override
  void initState() {
    super.initState();
    getIndayMatchedOrders();
  }

  Future<void> getIndayMatchedOrders() async {
    final listMatchedOrder = await dataCenterService
        .getIndayMatchedOrders(widget.stockModel.stock.stockCode);
    widget.stockModel
        .updateListMatchedOrder(listMatchedOrder.reversed.toList());
    setState(() {
      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return Center(
        child: Text(S.of(context).loading),
      );
    }
    return Column(
      children: [
        const _TabMatchedDetailHeader(),
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              physics: PanelScrollPhysics(controller: widget.panelController),
              controller: widget.scrollController,
              shrinkWrap: true,
              children: [
                for (final IndayMatchedOrder element
                    in widget.stockModel.listMatchedOrder)
                  _TabMatchedDetailRow(
                      element, widget.stockModel.stockData.getPriceColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TabMatchedDetailRow extends StatelessWidget {
  const _TabMatchedDetailRow(
    this.data,
    this.colorFunct,
  );
  final IndayMatchedOrder data;
  final Function colorFunct;

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
