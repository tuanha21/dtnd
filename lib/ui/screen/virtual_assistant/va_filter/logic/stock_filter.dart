class StockFilter {
  late final int id;
  late final String name;
  late final List<StockFigureFilter> stockFigureFilters;

  StockFilter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stockFigureFilters = [];
    for (var element in json['list']) {
      stockFigureFilters.add(StockFigureFilter.fromJson(element));
    }
  }
}

class StockFigureFilter {
  late final int id;
  late final String name;
  late final String valueType;

  String? value;

  StockFigureFilter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valueType = json['value_type'];
    name = json['sub_name'];
  }
}
