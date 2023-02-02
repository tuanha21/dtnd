import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/local/user_catalog.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/market/logic/cmd.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../data/implementations/local_storage_service.dart';
import '../../../../../utilities/logger.dart';

class RenameCatalogSheet extends StatefulWidget {
  const RenameCatalogSheet({
    super.key,
    required this.savedCatalog,
    required this.catalog,
  });

  final SavedCatalog savedCatalog;
  final LocalCatalog catalog;

  @override
  State<RenameCatalogSheet> createState() => _RenameCatalogSheetState();
}

class _RenameCatalogSheetState extends State<RenameCatalogSheet> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final FocusNode node = FocusNode();

  @override
  void initState() {
    controller.text = widget.catalog.name;
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
              title: S.of(context).edit_catalog_name,
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
                        widget.catalog.rename(controller.text);
                        final ILocalStorageService localStorageService =
                            LocalStorageService();
                        localStorageService
                            .putSavedCatalog(widget.savedCatalog);
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop(const NextCmd());
                        }
                      } catch (e) {
                        logger.e(e);
                        //Navigator.of(context).pop();
                      }
                    }
                  },
                  child: Text(S.of(context).save),
                )),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
          ],
        ),
      ),
    );
  }
}
