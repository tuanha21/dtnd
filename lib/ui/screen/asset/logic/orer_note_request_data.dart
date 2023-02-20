enum OrderStatusRequest { matched, waitingMatch, all }

enum OrderSideRequest { buy, sell, all }

extension OrderStatusRequestX on OrderStatusRequest {
  String get code {
    switch (this) {
      case OrderStatusRequest.matched:
        return "2";
      case OrderStatusRequest.waitingMatch:
        return "1";
      default:
        return "ALL";
    }
  }
}

extension OrderSideRequestX on OrderSideRequest {
  String get code {
    switch (this) {
      case OrderSideRequest.sell:
        return "S";
      case OrderSideRequest.buy:
        return "B";
      default:
        return "ALL";
    }
  }
}

class OrderNoteRequestData {
  final String? symbol;
  final OrderStatusRequest orderStatus;
  final OrderSideRequest orderSide;

  OrderNoteRequestData({
    this.symbol,
    this.orderStatus = OrderStatusRequest.all,
    this.orderSide = OrderSideRequest.all,
  });
}
