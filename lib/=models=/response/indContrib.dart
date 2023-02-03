import 'dart:ui';
import '../../ui/screen/market/widget/industry_map.dart';

class IndContrib {
  String? dataDate;
  List<String>? name;
  List<String>? color;
  List<num>? value;
  List<String>? color1;
  List<num>? value1;
  List<num>? ptcolor;
  List<num>? ptvalue;
  List<num>? ptcolor1;
  List<num>? ptvalue1;
  List<num>? contribPoint;

  List<Map<String, dynamic>> get listMapValue {
    List<Map<String, dynamic>> list = [];
    for (int i = 0; i < name!.length; i++) {
      list.add({
        "name": mapIndustryList[name![i]] ?? name?[i] ?? "",
        "color": color != null ? HexColor(color![i]) : null,
        "value": value != null ? value![i] : null,
        "contribPoint": contribPoint != null ? contribPoint![i] : null
      });
    }
    if(list.isEmpty) return [];
    list.sort((a, b) {
      num numA = a['contribPoint'];
      num numB = b['contribPoint'];
      return numB.compareTo(numA);
    });
    return list;
  }

  IndContrib(
      {this.dataDate,
      this.name,
      this.color,
      this.value,
      this.color1,
      this.value1,
      this.ptcolor,
      this.ptvalue,
      this.ptcolor1,
      this.ptvalue1,
      this.contribPoint});

  IndContrib.fromJson(Map<String, dynamic> json) {
    if (json['dataDate'] != null) {
      dataDate = json['dataDate'];
    }
    if (json['name'] != null) {
      name = json['name'].cast<String>();
    }
    if (json['color'] != null) {
      color = json['color'].cast<String>();
    }
    if (json['value'] != null) {
      value = json['value'].cast<double>();
    }
    if (json['color1'] != null) {
      color1 = json['color1'].cast<String>();
    }
    if (json['value1'] != null) {
      value1 = json['value1'].cast<double>();
    }
    if (json['ptcolor'] != null) {
      ptcolor = json['ptcolor'].cast<double>();
    }
    if (json['ptvalue'] != null) {
      ptvalue = json['value'].cast<double>();
    }
    if (json['ptcolor1'] != null) {
      ptcolor1 = json['ptcolor1'].cast<double>();
    }
    if (json['ptvalue1'] != null) {
      ptvalue1 = json['ptvalue1'].cast<double>();
    }
    if (json['contribPoint'] != null) {
      contribPoint = json['contribPoint'].cast<double>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dataDate'] = dataDate;
    data['name'] = name;
    data['color'] = color;
    data['value'] = value;
    data['color1'] = color1;
    data['value1'] = value1;
    data['ptcolor'] = ptcolor;
    data['ptvalue'] = ptvalue;
    data['ptcolor1'] = ptcolor1;
    data['ptvalue1'] = ptvalue1;
    data['contribPoint'] = contribPoint;
    return data;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
