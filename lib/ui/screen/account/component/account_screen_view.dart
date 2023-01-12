import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/account/component/account_total_asset_widget.dart';
import 'package:dtnd/ui/screen/account/icon/account_icon.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class AccountScreenView extends StatelessWidget {
  const AccountScreenView({super.key, required this.userService});
  final IUserService userService;
  @override
  Widget build(BuildContext context) {
    final info = userService.userInfo;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
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
          const AccountTotalAssetWidget()
        ],
      ),
    );
  }
}
