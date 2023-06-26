import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/local/user_catalog.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CreateCatalogSheet extends StatefulWidget {
  const CreateCatalogSheet({
    super.key,
    required this.savedCatalog,
    this.isBack = false,
  });

  final SavedCatalog savedCatalog;
  final bool isBack;

  @override
  State<CreateCatalogSheet> createState() => _CreateCatalogSheetState();
}

class _CreateCatalogSheetState extends State<CreateCatalogSheet>
    with AppValidator {
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
              implementBackButton: widget.isBack,
              backData: const BackCmd(),
            ),
            Form(
              key: key,
              child: TextFormField(
                validator: catalogNameValidator,
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
                        final UserCatalog newCatalog =
                            UserCatalog(controller.text, []);
                        if (!widget.savedCatalog.catalogs.any(
                            (catalog) => catalog.name == controller.text)) {
                          widget.savedCatalog.addCatalog(newCatalog);

                          /// trường hợp ở màn thị trường
                          if (!widget.isBack) {
                            Navigator.of(context).pop(BackCmd(newCatalog));
                          }

                          /// trường hợp ở màn chi tiết mã
                          else {
                            Navigator.of(context)
                                .pop(BackCmd(widget.savedCatalog));
                          }
                        } else {
                          EasyLoading.showToast(
                              S.of(context).Catalog_already_exists);
                        }
                      } catch (e) {
                        Navigator.of(context).pop();
                      }
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
