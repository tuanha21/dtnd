import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/sheet/sheet_flow.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';

class ExtensionsSheet extends StatefulWidget {
  const ExtensionsSheet({
    super.key,
  });
  @override
  State<ExtensionsSheet> createState() => _ExtensionsSheetState();
}

class _ExtensionsSheetState extends State<ExtensionsSheet> {
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
              title: S.of(context).other_functions,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: themeMode.isLight
                    ? AppColors.neutral_06
                    : AppColors.bg_share_inside_nav,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _RowButton(
                    themeMode: themeMode,
                    icon: AppImages.document,
                    label: S.of(context).order_note,
                    onTap: () =>
                        Navigator.of(context).pop(const ToBaseNoteCmd()),
                  ),
                  _RowButton(
                    themeMode: themeMode,
                    icon: AppImages.document_filter,
                    label: S.of(context).order_history,
                    onTap: () =>
                        Navigator.of(context).pop(const ToOrderHistoryCmd()),
                  ),
                  _RowButton(
                    themeMode: themeMode,
                    icon: AppImages.wallet,
                    label: S.of(context).executed_profit_and_loss,
                    onTap: () =>
                        Navigator.of(context).pop(const ToProfitAndLossCmd()),
                  ),
                  _RowButton(
                    themeMode: themeMode,
                    icon: AppImages.card_tick,
                    label: S.of(context).margin_debt,
                    onTap: () =>
                        Navigator.of(context).pop(const ToMarginDebt()),
                  ),
                ],
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
    required this.themeMode,
    required this.icon,
    required this.label,
    this.onTap,
  }) : super(key: key);
  final ThemeMode themeMode;
  final String icon;
  final String label;
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
                      : AppColors.primary_02,
                ),
                child: Image.asset(
                  icon,
                  width: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(label)),
            ],
          ),
        ),
      ),
    );
  }
}
