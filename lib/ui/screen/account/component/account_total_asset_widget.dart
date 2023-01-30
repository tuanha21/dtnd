import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

class AccountTotalAssetWidget extends StatefulWidget {
  const AccountTotalAssetWidget({
    Key? key,
    this.asset = "79,800,000đ",
  }) : super(key: key);
  final String asset;

  @override
  State<AccountTotalAssetWidget> createState() =>
      _AccountTotalAssetWidgetState();
}

class _AccountTotalAssetWidgetState extends State<AccountTotalAssetWidget> {
  bool showAsset = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage(AppImages.wallet_bg), fit: BoxFit.fitWidth),
      ),
      height: 124,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                S.of(context).total_asset,
                style: textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                  onTap: () => setState(() {
                        showAsset = !showAsset;
                      }),
                  child: showAsset
                      ? const Icon(Icons.visibility_off, color: Colors.white)
                      : const Icon(Icons.visibility, color: Colors.white)),
            ],
          ),
          showAsset
              ? Text(
                  widget.asset,
                  style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.white),
                )
              : Text(
                  "***************",
                  style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
          showAsset
              ? Row(
                  children: [
                    Image.asset(
                      AppImages.prefix_up_icon,
                      width: 10,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "2,108.63 (0.92%)",
                      style: textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.semantic_01),
                    ),
                  ],
                )
              : Text(
                  "***************",
                  style: textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
        ],
      ),
    );
  }
}
