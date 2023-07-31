import 'package:dtnd/=models=/response/commodity_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/lang_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CommodityItem extends StatelessWidget {
  const CommodityItem(
      {super.key, required this.data, this.selectedSymbol, this.onSelected});
  final CommodityModel data;
  final CommodityModel? selectedSymbol;
  final ValueChanged<CommodityModel>? onSelected;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    final img =
        LanguageUtil.toUnsigned(data.nAME).toLowerCase().removeAllWhitespace;
    BoxBorder? border;
    if (selectedSymbol != null && data == selectedSymbol) {
      border = Border.all(color: AppColors.neutral_04);
    }
    VoidCallback? onTap;
    if (onSelected != null) {
      onTap = () {
        onSelected?.call(data);
      };
    }
    return Material(
      color: themeData.colorScheme.background,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Ink(
          width: 148,
          height: 56,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: border,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: themeData.colorScheme.background,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox.square(
                      dimension: 15,
                      child:
                          SvgPicture.asset("assets/commodities_icon/$img.svg")),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      data.nAME,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.lASTPRICE ?? "0",
                    style: AppTextStyle.labelMedium_12.copyWith(
                      fontWeight: FontWeight.w600,
                      color: data.color,
                    ),
                  ),
                  Text(
                    "(${data.pERCENTCHANGE})",
                    style: AppTextStyle.bodySmall_8.copyWith(
                      fontWeight: FontWeight.w600,
                      color: data.color,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    data.pOINTCHANGE ?? "0",
                    style: AppTextStyle.labelMedium_12.copyWith(
                      fontWeight: FontWeight.w600,
                      color: data.color,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
