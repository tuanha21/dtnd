abstract class OrderValidityPeriod {
  DateTime? _orderExecuteTime;

  final bool isConst;

  OrderValidityPeriod({DateTime? orderExecuteTime, this.isConst = true})
      : _orderExecuteTime = orderExecuteTime;

  void changeTime(DateTime dateTime) {
    if (isConst) {
      return;
    }
    _orderExecuteTime = dateTime;
  }
}

class OrderValidityPeriodInday extends OrderValidityPeriod {
  OrderValidityPeriodInday({super.orderExecuteTime});
}

class OrderValidityPeriodNextday extends OrderValidityPeriod {
  OrderValidityPeriodNextday({super.orderExecuteTime});
}

class OrderValidityPeriodCustomday extends OrderValidityPeriod {
  OrderValidityPeriodCustomday() : super(isConst: false);
}
