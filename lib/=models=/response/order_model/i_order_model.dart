enum OrderStatus {
  partialMatch,
  pendingMatch,
  fullMatch,
  partialMatchCanceled,
  partialMatchWaitingCanceled,
  pendingCanceled,
  canceled,
}

abstract class IOrderModel {
  late final String id;
  late final String orderAccount;
  late final String symbol;
  late final DateTime orderTime;
  late final String orderStatus;
  num get matchPrice;
}
