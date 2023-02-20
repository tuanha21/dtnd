import 'package:dtnd/=models=/response/account/base_margin_account_model.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/screen/base_asset/base_asset_screen.dart';
import 'package:dtnd/ui/screen/asset/screen/copytrade_asset/copytrade_asset_screen.dart';
import 'package:dtnd/ui/screen/asset/screen/derivative_asset/derivative_asset_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/implementations/user_service.dart';

class AccountTypeAssetWidget extends StatefulWidget {
  const AccountTypeAssetWidget({super.key});

  @override
  State<AccountTypeAssetWidget> createState() => _AccountTypeAssetWidgetState();
}

class _AccountTypeAssetWidgetState extends State<AccountTypeAssetWidget> {
  final IUserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Obx(() {
            if (userService.listAccountModel.value?.isNotEmpty ?? false) {
              final data = userService.listAccountModel.value!.firstWhere(
                      (element) =>
                          element.runtimeType == BaseMarginAccountModel)
                  as BaseMarginAccountModel;
              return _StockType(
                label: S.of(context).base,
                value: "${NumUtils.formatDouble(data.equity ?? 0)}đ",
                accCode: data.accCode,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const BaseAssetScreen(),
                  ));
                },
              );
            } else {
              return _StockType(
                label: S.of(context).base,
                value: "-",
                accCode: "-",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const BaseAssetScreen(),
                  ));
                },
              );
            }
          }),
          const SizedBox(width: 10),
          _StockType(
            label: S.of(context).derivative,
            value: "800.000.000đ",
            accCode: "005C193380",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const DerivativeAssetScreen(),
              ));
            },
          ),
          const SizedBox(width: 10),
          _StockType(
            label: "CopyTrade",
            value: "800.000.000đ",
            accCode: "005C193380",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CopytradeAssetScreen(),
              ));
            },
          ),
        ],
      ),
    );
  }
}

class _StockType extends StatelessWidget {
  const _StockType({
    Key? key,
    required this.label,
    required this.value,
    this.onTap,
    required this.accCode,
  }) : super(key: key);
  final String label;
  final String value;
  final String accCode;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Ink(
          height: 100,
          width: 188,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: textTheme.labelMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      value,
                      style: textTheme.labelLarge!
                          .copyWith(fontWeight: FontWeight.w700),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      accCode,
                      style: textTheme.labelSmall!
                          .copyWith(color: AppColors.neutral_03),
                    ),
                  ),
                  Text(
                    "+12%",
                    style: textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.semantic_01),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
