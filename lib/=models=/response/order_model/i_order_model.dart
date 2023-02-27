import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

enum OrderStatus {
  partialMatch,
  pendingMatch,
  fullMatch,
  partialMatchCanceled,
  partialMatchWaitingCanceled,
  pendingCanceled,
  canceled,
  unidentified,
}

extension OrderStatusX on OrderStatus {
  String statusName(BuildContext context) {
    switch (this) {
      case OrderStatus.fullMatch:
        return "Đã khớp";
      case OrderStatus.partialMatch:
        return "Khớp 1 phần";
      case OrderStatus.pendingCanceled:
        return "Chờ huỷ";
      case OrderStatus.pendingMatch:
        return "Chờ khớp";
      case OrderStatus.partialMatchWaitingCanceled:
        return "Khớp 1 phần chờ huỷ";
      case OrderStatus.partialMatchCanceled:
        return "Khớp 1 phần đã huỷ";
      case OrderStatus.canceled:
        return "Đã huỷ";
      case OrderStatus.unidentified:
        return "Không xác định";
    }
  }

  bool get canEdit =>
      [OrderStatus.partialMatch, OrderStatus.pendingMatch].contains(this);

  Color get color {
    switch (this) {
      case OrderStatus.fullMatch:
        return AppColors.semantic_01;
      case OrderStatus.partialMatch:
        return AppColors.semantic_01;
      case OrderStatus.pendingCanceled:
        return AppColors.semantic_02;
      case OrderStatus.pendingMatch:
        return AppColors.semantic_02;
      case OrderStatus.partialMatchWaitingCanceled:
        return AppColors.semantic_02;
      case OrderStatus.partialMatchCanceled:
        return AppColors.semantic_01;
      case OrderStatus.canceled:
        return AppColors.semantic_03;
      case OrderStatus.unidentified:
        return AppColors.semantic_03;
    }
  }
}

abstract class IOrderModel {
  late final String id;
  late final String orderAccount;
  late final String symbol;
  late final DateTime orderTime;
  late final OrderStatus orderStatus;
  num get matchPrice;
}
