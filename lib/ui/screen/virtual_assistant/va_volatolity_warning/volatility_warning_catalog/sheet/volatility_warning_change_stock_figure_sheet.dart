import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';

class VolatilityWarningChangeStockFigureSheet extends StatefulWidget {
  const VolatilityWarningChangeStockFigureSheet({
    super.key,
    // required this.stock,
  });

  // final VolatilityWarningCatalogStock stock;

  @override
  State<VolatilityWarningChangeStockFigureSheet> createState() =>
      _VolatilityWarningChangeStockFigureSheetState();
}

class _VolatilityWarningChangeStockFigureSheetState
    extends State<VolatilityWarningChangeStockFigureSheet> {
  final ILocalStorageService localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SheetHeader(
              title: "widget.stock.stock",
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
