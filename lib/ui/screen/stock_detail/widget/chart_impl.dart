// updateCommonBehaviorimport 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/gestures.dart';

// class LineTouchTooltip extends charts.ChartBehavior<charts.LineChartData> {
//   final double tooltipBgColorOpacity;
//   final bool fitInsideVertically;

//   LineTouchTooltip({
//     this.tooltipBgColorOpacity = 0.9,
//     this.fitInsideVertically = true,
//   });

//   @override
//   charts.ChartBehavior<charts.LineChartData> createCommonBehavior(
//       charts.ChartContext context,
//       charts.CommonBehaviorListener behaviorListener) {
//     return this;
//   }

//   @override
//   int get desiredGestures =>
//       charts.BehaviorPosition.touch |
//       charts.BehaviorPosition.inside |
//       charts.BehaviorPosition.outside;

//   @override
//   String get role => 'lineTouchTooltip';

//   @override
//   void updateCommonBehavior(charts.ChartCanvas canvas,
//       charts.ChartViewGridData chartViewGridData,
//       charts.PositionedSeries positionedSeries,
//       List<num> data,
//       PointerEvent event,
//       charts.SelectionModelType selectionModelType) {}

//   /// Show/hide the tooltip on tap.
//   void onTap(charts.Point<int> point) {
//     final LineChartDrawMorpher morpher =
//         _getTransition(chart.context.drawAreaWidth, chart);

//     final current = morpher.currentDrawing;
//     final next = morpher.nextDrawing;
//     int hoveredIndex = _findHoveredIndex(point.x, chart);

//     if (hoveredIndex == null) {
//       current.resetHighlight();
//       next.resetHighlight();
//       behaviorListener.onLineTouch([], null);
//       return;
//     }

//     current.highlight(hoveredIndex);
//     next.highlight(hoveredIndex);

//     // Create a list with the points for each series that pass through the
//     // currently hovered over index.
//     final selectedValues = <charts.SeriesDatum>{};

//     chart.currentSeriesList.forEach((line) {
//       if (line.measureFn != null && line.data.length > hoveredIndex) {
//         var measure = line.measureFn(hoveredIndex);
//         if (measure != null) {
//           selectedValues.add(new charts.SeriesDatum(
//               series: line, datum: line.data[hoveredIndex], index: hoveredIndex));
//         }
//       }
//     });

//     behaviorListener.onLineTouch(selectedValues, point);
//   }

//   /// Handle a hover event.
//   void onHover(charts.Point<int> point) {
//     final LineChartDrawMorpher morpher =
//         _getTransition(chart.context.drawAreaWidth, chart);

//     final current = morpher.currentDrawing;
//     final next = morpher.nextDrawing;
//     int hoveredIndex = _findHoveredIndex(point.x, chart);

//     if (hoveredIndex == null) {
//       current.resetHighlight();
//       next.resetHighlight();
//       behaviorListener.onLineTouch([], null);
//       return;
//     }

//     current.highlight(hoveredIndex);
//     next.highlight(hoveredIndex);

//     // Create a list with the points for each series that pass through the
//     // currently hovered over index.
//     final selectedValues = <charts.SeriesDatum>{};

//     chart.currentSeriesList.forEach((line) {
//       if (line.measureFn != null && line.data.length > hoveredIndex) {
//         var measure = line.measureFn(hoveredIndex);
//         if (measure != null) {
//           selectedValues.add(new charts.SeriesDatum(
//               series: line, datum: line.data[hoveredIndex], index: hoveredIndex));
//         }
//       }
//     });

//     behaviorListener.onLineTouch(selectedValues, point);
//   }

//   /// Find the x coordinates of the nearest data points on the line for the
//   /// given x position.
//   int _findHoveredIndex(int xPos, charts.LineChart<dynamic> chart) {
//     if (chart.seriesList.isEmpty) {
//       return null;
//     }
//     final firstLine = chart.seriesList.first;
//     if (firstLine.data.isEmpty) {
//       return null;
//     }

//     final component = chart.currentRenderingElement?.component;
//     if (component == null) {
//       throw Exception('Unable to find component attached to rendering element');
//     }

//     final prevIndices = new Map<String, int>.fromIterable(
//       chart.seriesList,
//       key: (dynamic s) => '${s.id}${s.displayName ?? ''}',
//       value: (dynamic s) => -1,
//     );

//     for (int i = 0; i < chart.lastRenderingDetails.chartData.length; i++) {
//       chart.lastRenderingDetails.chartData[i].forEach((datum) {
//         final datumMaxX = component.getXPixel(datum.index + 1);
//         if ( 
