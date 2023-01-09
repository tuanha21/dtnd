import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/overlay/app_dialog.dart';
import 'package:flutter/material.dart';

class DeleteCatalogDialog extends StatelessWidget {
  const DeleteCatalogDialog({
    super.key,
    required this.savedCatalog,
    required this.catalog,
  });
  final SavedCatalog savedCatalog;
  final LocalCatalog catalog;
  @override
  Widget build(BuildContext context) {
    return AppDialog(
      icon: const Icon(Icons.warning_amber_rounded),
      title: Text(S.of(context).delete_catalog),
      content: Text(S.of(context).are_you_sure_to_delete_catalog(catalog.name)),
      actions: [
        Flexible(
          child: InkWell(
              onTap: () => Navigator.of(context).pop(const BackCmd()),
              child: Container(
                alignment: Alignment.center,
                child: Text(S.of(context).cancel),
              )),
        ),
        Flexible(
          child: InkWell(
              onTap: () {
                savedCatalog.removeCatalog(catalog);
                Navigator.of(context).pop(const NextCmd());
              },
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: AppColors.neutral_05),
                  ),
                ),
                child: const Text("OK"),
              )),
        )
      ],
    );
  }
}
