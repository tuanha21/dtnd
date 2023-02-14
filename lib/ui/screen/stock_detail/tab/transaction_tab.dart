import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../=models=/response/stock_model.dart';
import '../../../theme/app_color.dart';
import '../widget/foreign_widget.dart';
import '../widget/tab_matched_detail.dart';
import '../widget/tab_trading_board.dart';

class TransactionTab extends StatefulWidget {
  final StockModel stockModel;

  const TransactionTab({Key? key, required this.stockModel}) : super(key: key);

  @override
  State<TransactionTab> createState() => _TransactionTabState();
}

class _TransactionTabState extends State<TransactionTab> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: const SizedBox(),
            automaticallyImplyLeading: false,
            // pinned: false,
            // toolbarHeight: 200,
            expandedHeight: 240,
            floating: true,
            flexibleSpace: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  TabTradingBoard(stockModel: widget.stockModel),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Giá thấp nhất',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: AppColors.neutral_04),
                            ),
                            Text(
                              'Giá cao nhất',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: AppColors.neutral_04),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.stockModel.stockData.lowPrice.value
                                  .toString(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Expanded(
                              child: Builder(
                                builder: (context) {
                                  return LinearPercentIndicator(
                                    barRadius: const Radius.circular(12),
                                    animation: true,
                                    animationDuration: 1000,
                                    lineHeight: 10,
                                    percent: widget.stockModel.stockData.percent
                                        .toDouble(),
                                    progressColor: AppColors.neutral_03,
                                    backgroundColor: AppColors.neutral_01,
                                  );
                                },
                              ),
                            ),
                            Text(
                              widget.stockModel.stockData.highPrice.value
                                  .toString(),
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  ForeignWidget(stockModel: widget.stockModel)
                ],
              ),
            ),
          )
        ];
      },
      body: TabMatchedDetail(
        stockModel: widget.stockModel,
      ),
    );
  }
}
