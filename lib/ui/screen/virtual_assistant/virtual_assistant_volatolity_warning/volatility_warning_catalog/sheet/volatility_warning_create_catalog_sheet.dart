import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/local/volatility_warning_catalog.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VolatilityWarningCreateCatalogSheet extends StatefulWidget {
  const VolatilityWarningCreateCatalogSheet({
    super.key,
    required this.savedCatalog,
  });
  final SavedCatalog<VolatilityWarningCatalogStock> savedCatalog;
  @override
  State<VolatilityWarningCreateCatalogSheet> createState() =>
      _VolatilityWarningCreateCatalogSheetState();
}

class _VolatilityWarningCreateCatalogSheetState
    extends State<VolatilityWarningCreateCatalogSheet> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final FocusNode node = FocusNode();
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
              title: S.of(context).create_catalog,
            ),
            Form(
              key: key,
              child: TextFormField(
                validator: AppValidator.catalogNameValidator,
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
                decoration: InputDecoration(
                  labelText: S.of(context).catalog_name,
                ),
                controller: controller,
                focusNode: node,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    if (key.currentState?.validate() ?? false) {
                      try {
                        final VolatilityWarningCatalog newCatalog =
                            VolatilityWarningCatalog(controller.text);
                        widget.savedCatalog.catalogs.add(newCatalog);
                        widget.savedCatalog.save();
                      } catch (e) {
                        Navigator.of(context).pop(const BackCmd());
                      }
                      Navigator.of(context).pop(const BackCmd());
                    }
                  },
                  child: Text(S.of(context).save),
                )),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
