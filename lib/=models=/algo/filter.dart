import 'dart:convert';

class Filter {
  int? filterId;
  String? name;
  String? exchangeCode;
  String? criteria;
  String? industryCode;

  List<FilterRange> get list {
    if (criteria == null || criteria!.isEmpty) return [];
    List listData = jsonDecode(criteria!);
    List<FilterRange> listFilterRange = [];
    for (var element in listData) {
      listFilterRange.add(FilterRange.fromJson(element));
    }
    return listFilterRange;
  }

  List<String> get listMarket {
    if (exchangeCode == null) return [];
    return exchangeCode!.split(",");
  }

  List<String> get listIndustryCode {
    if (industryCode == null) return [];
    return industryCode!.split(",");
  }

  Filter(
      {this.filterId,
      this.name,
      this.exchangeCode,
      this.criteria,
      this.industryCode});

  Filter.fromJson(Map<String, dynamic> json) {
    filterId = json['FilterId'];
    name = json['Name'];
    exchangeCode = json['ExchangeCode'];
    criteria = json['Criteria'];
    industryCode = json['IndustryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FilterId'] = filterId;
    data['Name'] = name;
    data['ExchangeCode'] = exchangeCode;
    data['IndustryCode'] = industryCode;
    data['Criteria'] = criteria;
    return data;
  }
}

class FilterRange {
  String? code;
  num? low;
  num? high;

  FilterRange({this.code, this.low, this.high});

  FilterRange.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    low = json['low'];
    high = json['high'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['low'] = low;
    data['high'] = high;
    return data;
  }
}
