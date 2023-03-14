import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/component/account_total_asset_widget.dart';
import 'package:dtnd/ui/screen/account/component/extensions_widget.dart';
import 'package:dtnd/ui/screen/account/icon/account_icon.dart';
import 'package:dtnd/ui/screen/account/sheet/sheet_config.dart';
import 'package:dtnd/ui/screen/account/sheet/user_info_detailt_sheet.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountScreenView extends StatelessWidget {
  const AccountScreenView({super.key, required this.userService});

  final IUserService userService;

  @override
  Widget build(BuildContext context) {
    final info = userService.userInfo.value;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info?.cCUSTFULLNAME ?? "",
                    style: textTheme.titleSmall!.copyWith(
                        color: AppColors.primary_01,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    info?.cCUSTOMERCODE ?? "",
                    style: textTheme.bodySmall!
                        .copyWith(color: AppColors.neutral_03),
                  ),
                ],
              ),
              Material(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: InkWell(
                  onTap: () {
                    const UserInfoDetailISheet()
                        .show(context, UserInfoDetailSheet(userInfo: info!));
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Ink(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: AppColors.accent_light_04,
                    ),
                    child: Image.asset(
                      AccountIcon.people,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          const AccountTotalAssetWidget(),
          const SizedBox(height: 16),
          const AccountExtensionsWidget(),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Version 1.0"),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    context.go("/SignIn");
                  },
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
                  child: Text(S.of(context).logout),
                ),
              ),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
