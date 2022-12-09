class FilterCriterion {
  late final int id;
  late final String name;
  late final List<FilterCriterionFigure> filterCriterionFigure;
  FilterCriterion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    filterCriterionFigure = [];
    for (var element in json['list']) {
      filterCriterionFigure.add(FilterCriterionFigure.fromJson(element));
    }
  }
}

class FilterCriterionFigure {
  late final int id;
  late final String name;
  late final String valueType;
  String value = "";

  FilterCriterionFigure.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valueType = json['value_type'];
    name = json['sub_name'];
  }
}
