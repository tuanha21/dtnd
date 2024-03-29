import 'package:dtnd/=models=/response/order_model/i_order_model.dart';
import 'package:dtnd/=models=/side.dart';

class OrderFilterData {
  Side? orderType;
  List<OrderStatus>? orderStatus;

  @override
  String toString() {
    return 'OrderFilterData{orderType: $orderType, orderStatus: $orderStatus}';
  }
}

class OrderHistoryFilterData {
  Side? orderType;
  List<OrderStatus>? orderStatus;
}
