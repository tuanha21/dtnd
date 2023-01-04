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
