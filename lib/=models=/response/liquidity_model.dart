import 'package:dtnd/utilities/logger.dart';

const int _interval = 5;

class LiquidityModel {
  final List<num> currVal = [];
  final List<num> prevVal = [];
  final List<num> week1Val = [];
  final List<num> week2Val = [];
  final List<num> monthVal = [];
  final List<num> currPTVal = [];
  final List<num> prevPTVal = [];
  final List<num> week1PTVal = [];
  final List<num> week2PTVal = [];
  final List<num> monthPTVal = [];
  final List<String> time = [
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "13:05",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
  ];

  LiquidityModel.fromJson(Map<String, dynamic> json) {
    currVal.addAll(json['currVal'].cast<num>());
    prevVal.addAll(json['prevVal'].cast<num>());
    week1Val.addAll(json['week1Val'].cast<num>());
    week2Val.addAll(json['week2Val'].cast<num>());
    monthVal.addAll(json['monthVal'].cast<num>());
    currPTVal.addAll(json['currPTVal'].cast<num>());
    prevPTVal.addAll(json['prevPTVal'].cast<num>());
    week1PTVal.addAll(json['week1PTVal'].cast<num>());
    week2PTVal.addAll(json['week2PTVal'].cast<num>());
    monthPTVal.addAll(json['monthPTVal'].cast<num>());

    _fold(currVal);
    _fold(prevVal);
    _fold(week1Val);
    _fold(week2Val);
    _fold(monthVal);
    _fold(currPTVal);
    _fold(prevPTVal);
    _fold(week1PTVal);
    _fold(week2PTVal);
    _fold(monthPTVal);
  }

  List<num> _fold(List<num> list) {
    final length = _length(list);
    final List<List<num>> sublist = [];
    final List<num> result = [];
    for (var i = 0; i < length; i++) {
      sublist.add(list.sublist(_interval * i, _interval * i + 5));
    }
    for (var element in sublist) {
      result.add(element.reduce((a, b) => a + b));
    }
    //logger.v(sublist);
    list.clear();
    list.addAll(result);
    return result;
  }

  int _length(List<num> list) {
    return (list.length ~/ _interval);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currVal'] = currVal;
    data['prevVal'] = prevVal;
    data['week1Val'] = week1Val;
    data['week2Val'] = week2Val;
    data['monthVal'] = monthVal;
    data['currPTVal'] = currPTVal;
    data['prevPTVal'] = prevPTVal;
    data['week1PTVal'] = week1PTVal;
    data['week2PTVal'] = week2PTVal;
    data['monthPTVal'] = monthPTVal;
    return data;
  }
}
