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
