import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';

class CancelOrderSuccessSheet extends StatelessWidget {
  const CancelOrderSuccessSheet({
    super.key,
    this.showButton = false,
  });
  final bool showButton;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.neutral_06,
      ),
       child: SingleChildScrollView(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             const SheetHeader(
               title: "",
               implementBackButton: false,
               implementDivider: false,
             ),
              Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 SizedBox.square(
                   dimension: 200,
                   child: Image.asset(AppImages.illust06),
                 )
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   S.of(context).cancel_order_successfully,
                   style: textTheme.labelLarge,
                 )
               ],
             ),
             const SizedBox(height: 10),
             showButton
                 ? Row(
               mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       TextButton(
                           onPressed: () {
                             Navigator.of(context).pop(const NextCmd());
                           },
                           child: Text(S.of(context).create_new_order)),
                     ],
                   )
                 : Container(),
             const SizedBox(height: 20),
           ],
         ),
       ),
    );
  }
}
