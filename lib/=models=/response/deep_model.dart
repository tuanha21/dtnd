class DeepModel {
  late final String tYPE;
  late final int sL;
  late final int sortValue;

  DeepModel({required this.tYPE, required this.sL}) {
    sortValue = _caculateSortValue(tYPE);
  }

  DeepModel.fromJson(Map<String, dynamic> json) {
    tYPE = json['TYPE'];
    sL = json['SL'];
    sortValue = _caculateSortValue(tYPE);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TYPE'] = tYPE;
    data['SL'] = sL;
    return data;
  }

  int _caculateSortValue(String data) {
    int value = 0;
    switch (data) {
      case "<=-7%":
        value = -8;
        break;
      case "-7--5%":
        value = -6;
        break;
      case "-5--3%":
        value = -4;
        break;
      case "-3--1%":
        value = -2;
        break;
      case "-1--0%":
        value = -1;
        break;
      case "0%":
        value = 0;
        break;
      case "0-1%":
        value = 1;
        break;
      case "1-3%":
        value = 2;
        break;
      case "3-5%":
        value = 4;
        break;
      case "5-7%":
        value = 6;
        break;
      case ">=7%":
        value = 8;
        break;
    }
    return value;
  }
}
