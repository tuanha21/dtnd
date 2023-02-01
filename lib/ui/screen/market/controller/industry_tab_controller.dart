import 'package:dtnd/=models=/ui_model/field_tree_element_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';

import '../../../../data/implementations/data_center_service.dart';

class IndustryTabController {
  static final IndustryTabController _instance =
      IndustryTabController._internal();

  IndustryTabController._internal();

  factory IndustryTabController() {
    return _instance;
  }

  final IDataCenterService dataCenterService = DataCenterService();

  final List<FieldTreeModel> model = [];

  Future<void> getData() async {}

  Future<void> getListIndustry() async {
    model.clear();
    model.addAll(
        await dataCenterService.getListIndustryHeatMap(top: 8, type: "KL"));
  }
}


final listIndustry = {
  "0500" : "Dầu khí",
  "1300" : "Hóa chất",
  "1700" : "Tài nguyên cơ bản",
  "2300" : "Xây dựng và vật liệu",
  "2700" : "Hàng & Dịch vụ Công nghiệp",
  "3300" : "Ô tô và phụ tùng",
  "3500" : "Thực phẩm và đồ uống",
  "3700" : "Hàng cá nhân & Gia dụng",
  "4500" : "Y tế",
  "5300" : "Bán lẻ",
  "5500" : "Truyền thông",
  "5700" : "Du lịch và Giải trí",
  "6500" : "Viễn thông",
  "7500" : "Tiện ích",
  "8300" : "Ngân hàng",
  "8500" : "Bảo hiểm",
  "8700" : "Dịch vụ tài chính",
  "9500" : "Công nghệ Thông tin"
};
