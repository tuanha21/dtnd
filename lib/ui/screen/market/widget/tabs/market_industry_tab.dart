import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/market/widget/components/heap_map_widget.dart';
import 'package:dtnd/ui/screen/market/widget/components/industry_info_widget.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/icon/active_button.dart';
import 'package:flutter/material.dart';

import '../../../../../=models=/index.dart';
import '../../../../../=models=/response/indContrib.dart';
import '../../../../../=models=/response/index_board.dart';
import '../../../../../=models=/response/liquidity_model.dart';
import '../../../../../=models=/response/top_influence_model.dart';
import '../../../../../data/i_data_center_service.dart';
import '../../../../../data/implementations/data_center_service.dart';
import '../components/liquidity_chart.dart';
import '../components/money_chart.dart';
import '../components/top_index_widget.dart';
import '../components/top_influence_chart.dart';

class MarketIndustryTab extends StatefulWidget {
  const MarketIndustryTab({super.key});

  @override
  State<MarketIndustryTab> createState() => _MarketIndustryTabState();
}

class _MarketIndustryTabState extends State<MarketIndustryTab> {
  bool heapMapMode = true;

  void changeMode(bool newValue) {
    if (heapMapMode != newValue) {
      setState(() {
        heapMapMode = newValue;
      });
    }
  }

  Index indexSelect = Index.VN30;

  final IDataCenterService dataCenterService = DataCenterService();

  late Future<List<TopInfluenceModel>> topInfluenceList;
  late Future<List<IndexBoard>> indexBoard;
  late Future<LiquidityModel> liquidityModel;
  late Future<IndContrib> topIndex;

  @override
  void initState() {
    topInfluenceList = dataCenterService.getTopInfluence(indexSelect);
    indexBoard = dataCenterService.getIndexBoard(indexSelect.exchangeName);
    liquidityModel = dataCenterService.getLiquidity(indexSelect);
    topIndex = dataCenterService.getIndContrib(indexSelect.market);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleTextStyle =
        textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700);
    Widget tab;
    if (heapMapMode) {
      tab = const HeapMapWidget();
    } else {
      tab = const IndustryInfoWidget();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          //TopInfluenceChart(topInfluenceList: topInfluenceList),
          LiquidityChart(liquidityModel: liquidityModel),
          MoneyChart(indexBoard: indexBoard),
          TopIndexWidgetChart(topIndex: topIndex),
          const SizedBox(height: 100)
        ],
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(16),
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(
    //             S.of(context).industry_list,
    //             style: titleTextStyle,
    //           ),
    //           Row(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               ActiveButton(
    //                 icon: AppImages.element_3,
    //                 isActive: () => heapMapMode,
    //                 onActive: () => changeMode(true),
    //               ),
    //               const SizedBox(width: 10),
    //               ActiveButton(
    //                 icon: AppImages.textalign_justifycenter,
    //                 isActive: () => !heapMapMode,
    //                 onActive: () => changeMode(false),
    //               ),
    //             ],
    //           )
    //         ],
    //       ),
    //       const SizedBox(height: 10),
    //       Expanded(child: tab),
    //       const SizedBox(height: 100)
    //     ],
    //   ),
    // );
  }
}
