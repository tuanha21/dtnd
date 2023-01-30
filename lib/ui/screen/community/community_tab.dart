import 'package:flutter/material.dart';

import '../../widget/stock/stock_chart.dart';
import '../../widget/stock/stock_widget.dart';
import '../../widget/stock/stock_widget_chart.dart';
import 'widget/post_widget.dart';

class CommunityTab extends StatefulWidget {
  const CommunityTab({Key? key}) : super(key: key);

  @override
  State<CommunityTab> createState() => _CommunityTabState();
}

class _CommunityTabState extends State<CommunityTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StockWidget(),
          const SizedBox(height: 16),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const PostWidget();
                }
                return const PostWidget(
                  chart: Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: LineChartSample2(),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
              itemCount: 2),
          const SizedBox(height: 16),
          Text(
            '🔥 HOT',
            style: bodyLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const StockWidgetChart();
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
              itemCount: 3),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
