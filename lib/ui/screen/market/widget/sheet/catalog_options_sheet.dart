import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/market/logic/cmd.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';

enum CatalogOption {
  edit,
  delete,
}

extension CatalogOptionX on CatalogOption {
  String label(BuildContext context) {
    switch (this) {
      case CatalogOption.edit:
        return S.of(context).edit_catalog_name;
      case CatalogOption.delete:
        return S.of(context).delete_catalog;
    }
  }

  String get iconPath {
    switch (this) {
      case CatalogOption.edit:
        return AppImages.edit_icon;
      case CatalogOption.delete:
        return AppImages.trash_icon;
    }
  }

  VoidCallback onTap(BuildContext context) {
    switch (this) {
      case CatalogOption.edit:
        return () => Navigator.of(context).pop(const RenameCatalogCmd());
      case CatalogOption.delete:
        return () => Navigator.of(context).pop(const DeleteCatalogCmd());
    }
  }
}

class CatalogOptionsSheet extends StatefulWidget {
  const CatalogOptionsSheet({
    super.key,
    required this.savedCatalog,
    required this.catalog,
  });
  final SavedCatalog savedCatalog;
  final LocalCatalog catalog;
  @override
  State<CatalogOptionsSheet> createState() => _CatalogOptionsSheetState();
}

class _CatalogOptionsSheetState extends State<CatalogOptionsSheet> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final FocusNode node = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = AppService.instance.themeMode.value;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetHeader(
              implementBackButton: false,
              title: S.of(context).following_catalog_with(widget.catalog.name),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: themeMode.isLight
                    ? AppColors.neutral_06
                    : AppColors.neutral_06,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: CatalogOption.values.length,
                itemBuilder: (context, index) => _RowButton(
                  option: CatalogOption.values.elementAt(index),
                  themeMode: themeMode,
                  icon: CatalogOption.values.elementAt(index).iconPath,
                  onTap: CatalogOption.values.elementAt(index).onTap(context),
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _RowButton extends StatelessWidget {
  const _RowButton({
    Key? key,
    required this.option,
    required this.themeMode,
    required this.icon,
    this.onTap,
  }) : super(key: key);
  final CatalogOption option;
  final ThemeMode themeMode;
  final String icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: themeMode.isLight
                      ? AppColors.neutral_05
                      : AppColors.neutral_04,
                ),
                child: Image.asset(
                  option.iconPath,
                  width: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(option.label(context))),
            ],
          ),
        ),
      ),
    );
  }
}
