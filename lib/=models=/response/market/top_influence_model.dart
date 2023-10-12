class TopInfluenceModel {
  TopInfluenceModel({
    required this.stockCode,
    required this.val,
    required this.point,
  });
  late final String stockCode;
  late final num val;
  late final num point;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stockCode'] = stockCode;
    data['val'] = val;
    data['point'] = point;
    return data;
  }
}
