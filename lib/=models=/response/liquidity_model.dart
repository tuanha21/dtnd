import 'package:dtnd/utilities/logger.dart';

const int _interval = 6;

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
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
  ];

  LiquidityModel.fromJson(Map<String, dynamic> json) {
    try {
      currVal.addAll(_fold(json['currVal'].cast<num>()));
      logger.v(currVal);
      prevVal.addAll(_fold(json['prevVal'].cast<num>()));
      logger.v(prevVal);
      week1Val.addAll(_fold(json['week1Val'].cast<num>()));
      week2Val.addAll(_fold(json['week2Val'].cast<num>()));
      monthVal.addAll(_fold(json['monthVal'].cast<num>()));
      currPTVal.addAll(_fold(json['currPTVal'].cast<num>()));
      prevPTVal.addAll(_fold(json['prevPTVal'].cast<num>()));
      week1PTVal.addAll(_fold(json['week1PTVal'].cast<num>()));
      week2PTVal.addAll(_fold(json['week2PTVal'].cast<num>()));
      monthPTVal.addAll(_fold(json['monthPTVal'].cast<num>()));
    } catch (e) {
      logger.e(e);
    }
  }

  List<num> _fold(List<num> list) {
    final length = list.length;
    final List<num> sublist = [];
    for (var i = 0; i < length; i += _interval) {
      if (i == 0) {
        sublist.add(list.elementAt(6));
        i++;
      } else {
        if (length - 1 - i > 0 && length - 1 - i < _interval) {
          sublist.add(list.elementAt(length - 1));
        } else {
          sublist.add(list.elementAt(i + _interval - 1));
        }
      }
    }
    return sublist;
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
