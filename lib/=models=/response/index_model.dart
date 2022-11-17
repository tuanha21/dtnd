import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_chart_data.dart';
import 'package:dtnd/=models=/response/index_detail.dart';

class IndexModel {
  late final Index index;
  late final IndexDetail _indexDetail;
  final List<IndexChartData> _indexChartData = <IndexChartData>[];

  IndexDetail get indexDetail => _indexDetail;
  List<IndexChartData> get indexChartData => _indexChartData;

  IndexModel(
      {required this.index, required IndexDetailResponse indexDetailResponse}) {
    _indexDetail = IndexDetail.fromResponse(indexDetailResponse);
  }

  void updateIndexDetail(IndexDetailResponse data) {
    _indexDetail
      ..cIndex.value = data.cIndex
      ..ot.value = data.ot
      ..status.value = data.status
      ..value.value = data.value
      ..vol.value = data.vol
      ..time.value = data.time;
  }

  void replaceChartData(List<IndexChartData> data) {
    _indexChartData.clear();
    return _indexChartData.addAll(data);
  }

  void addChartData(IndexChartData data) {
    return _indexChartData.add(data);
  }

  @override
  bool operator ==(Object other) => other is IndexModel && index == other.index;

  @override
  int get hashCode => Object.hash(index, _indexDetail);
}
