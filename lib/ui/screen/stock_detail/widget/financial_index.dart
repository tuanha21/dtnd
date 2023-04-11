import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

enum _RowType { esp, ppe, ppb, dividend }

extension _RowTypeX on _RowType {
  String label(BuildContext context) {
    switch (this) {
      case _RowType.dividend:
        return "P/S (Price/Sales)";
      case _RowType.esp:
        return "EPS (Earning Per Share)";
      case _RowType.ppe:
        return "P/E (Price/EPS)";
      case _RowType.ppb:
        return "P/B (Price/Book)";
    }
  }

  String tooltip(BuildContext context) {
    switch (this) {
      case _RowType.dividend:
        return "P/S (Price/Sales) : Được tính bằng Vốn hóa chia cho Doanh thu 4 quý gần nhất.";
      case _RowType.esp:
        return "EPS: Được tính bằng Cổ đông của công ty mẹ 4 quý gần nhất chia cho Bình quân số lượng cổ phiếu đang lưu hành 4 quý tương ứng.";
      case _RowType.ppe:
        return "P/E: Được tính bằng Vốn hóa chia cho tổng Cổ đông của công ty mẹ 4 quý gần nhất.";
      case _RowType.ppb:
        return "P/B: Được tính bằng Vốn hóa chia cho Giá trị sổ sách quý gần nhất.";
    }
  }

  String value(StockModel model) {
    switch (this) {
      case _RowType.dividend:
        return "${NumUtils.formatDouble(model.securityBasicInfo.value?.pS ?? 0)} lần";
      case _RowType.esp:
        return "${NumUtils.formatDouble(model.securityBasicInfo.value?.ePS ?? 0)} VND";
      case _RowType.ppe:
        return "${NumUtils.formatDouble(model.securityBasicInfo.value?.pE ?? 0)} lần";
      case _RowType.ppb:
        return "${NumUtils.formatDouble(model.securityBasicInfo.value?.pB ?? 0)} lần";
    }
  }
}

class FinancialIndex extends StatelessWidget {
  const FinancialIndex({
    super.key,
    required this.stockModel,
  });

  final StockModel stockModel;

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeMode.isDark ? AppColors.neutral_01 : AppColors.neutral_06,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            for (final _RowType type in _RowType.values)
              _RowData(
                type: type,
                stockModel: stockModel,
              )
          ],
        ));
  }
}

class _RowData extends StatelessWidget {
  const _RowData({
    required this.type,
    required this.stockModel,
  });

  final _RowType type;
  final StockModel stockModel;

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            type.label(context),
            style: AppTextStyle.bodySmall_12.copyWith(
              color: themeMode.isDark
                  ? AppColors.neutral_06
                  : AppColors.neutral_03,
            ),
          ),
          Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: type.tooltip(context),
            textStyle: AppTextStyle.bodySmall_12.copyWith(
              color: themeMode.isDark
                  ? AppColors.neutral_03
                  : AppColors.neutral_06,
            ),
            margin: const EdgeInsets.all(0),
            showDuration: const Duration(seconds: 5),
            preferBelow: false,
            height: 20,
            verticalOffset: 10,
            child: Icon(
              Icons.info_outline,
              size: 10,
              color: themeMode.isDark
                  ? AppColors.neutral_06
                  : AppColors.neutral_03,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Text(type.value(stockModel))
        ],
      ),
    );
  }
}
