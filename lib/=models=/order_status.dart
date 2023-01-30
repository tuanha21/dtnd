import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

enum OrderStatus { waitingMatch, matched, matching }

extension OrderStatusX on OrderStatus {
  String name(BuildContext context) {
    switch (this) {
      case OrderStatus.waitingMatch:
        return S.of(context).waiting_match;
      case OrderStatus.matched:
        return S.of(context).matched;
      case OrderStatus.matching:
        return S.of(context).matching;
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.waitingMatch:
        return AppColors.semantic_02;
      case OrderStatus.matched:
        return AppColors.semantic_01;
      case OrderStatus.matching:
        return AppColors.semantic_01;
    }
  }
}
