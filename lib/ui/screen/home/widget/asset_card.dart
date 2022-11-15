import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeAssetCard extends StatefulWidget {
  const HomeAssetCard({super.key});

  @override
  State<HomeAssetCard> createState() => _HomeAssetCardState();
}

class _HomeAssetCardState extends State<HomeAssetCard> {
  final AppService appService = AppService();
  bool showAsset = false;

  @override
  Widget build(BuildContext context) {
    final BoxConstraints constraints = BoxConstraints.expand(
        width: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width - 32
            : 850,
        height: 84);
    return Center(
      child: ObxValue<Rx<ThemeMode>>((themeMode) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          constraints: constraints,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            image: DecorationImage(
              image: AssetImage(themeMode.value == ThemeMode.light
                  ? AppImages.home_asset_card_light_bg
                  : AppImages.home_asset_card_dark_bg),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(S.of(context).total_asset),
                      const SizedBox(
                        width: 13,
                      ),
                      GestureDetector(
                          onTap: () => setState(() {
                                showAsset = !showAsset;
                              }),
                          child: showAsset
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility)),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.home_asset_card_wallet,
                        color: themeMode.value == ThemeMode.light
                            ? AppColors.neutral_01
                            : AppColors.neutral_07,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      showAsset ? Text("0 VND") : Text("********"),
                    ],
                  ),
                ],
              )),
            ],
          ),
        );
      }, appService.themeMode),
    );
  }
}
