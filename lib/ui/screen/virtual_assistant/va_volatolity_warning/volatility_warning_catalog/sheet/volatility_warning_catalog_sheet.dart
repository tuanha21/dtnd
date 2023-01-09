import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/volatility_warning_catalog/component/user_warning_catalog_widget.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';

class VolatilityWarningCatalogSheet extends StatefulWidget {
  const VolatilityWarningCatalogSheet({
    super.key,
    required this.savedCatalog,
  });
  final SavedCatalog savedCatalog;
  @override
  State<VolatilityWarningCatalogSheet> createState() =>
      _VolatilityWarningCatalogSheetState();
}

class _VolatilityWarningCatalogSheetState
    extends State<VolatilityWarningCatalogSheet> {
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
          children: [
            SheetHeader(
              title: S.of(context).add_catalog,
              implementBackButton: false,
            ),
            UserWarningCatalogWidget(savedCatalog: widget.savedCatalog),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
