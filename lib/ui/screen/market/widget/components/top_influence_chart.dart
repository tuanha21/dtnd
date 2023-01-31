import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/top_influence_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TopInfluenceChart extends StatefulWidget {
  const TopInfluenceChart({super.key});

  @override
  State<TopInfluenceChart> createState() => _TopInfluenceChartState();
}

class _TopInfluenceChartState extends State<TopInfluenceChart> {
  final IDataCenterService dataCenterService = DataCenterService();
  final List<TopInfluenceModel> topInfluenceList = [];
  late List<charts.Series<TopInfluenceModel, String>> seriesList;
  bool initialized = false;
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    topInfluenceList.addAll(await dataCenterService.getTopInfluence(Index.VNI));
    seriesList = [
      charts.Series<TopInfluenceModel, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TopInfluenceModel model, _) => model.stockCode,
        measureFn: (TopInfluenceModel model, _) => model.point,
        fillColorFn: (TopInfluenceModel model, _) =>
            charts.ColorUtil.fromDartColor(model.point > 0
                ? AppColors.semantic_01
                : AppColors.semantic_03),
        data: topInfluenceList,
      )
    ];
    if(mounted){
      setState(() {
        initialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (!initialized) {
      child = Center(
        child: Text(S.of(context).loading),
      );
    } else {
      child = charts.BarChart(
        seriesList,
        animate: true,
        defaultRenderer: charts.BarRendererConfig(
          // By default, bar renderer will draw rounded bars with a constant
          // radius of 100.
          // To not have any rounded corners, use [NoCornerStrategy]
          // To change the radius of the bars, use [ConstCornerStrategy]
          cornerStrategy: const charts.ConstCornerStrategy(2),
        ),
        domainAxis: const charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
            labelRotation: 270,
            minimumPaddingBetweenLabelsPx: 0,
            labelOffsetFromAxisPx: 35,
          ),
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: child,
    );
  }
}
