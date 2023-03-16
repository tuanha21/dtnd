import 'package:dtnd/=models=/response/commodity_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class CommodityItem extends StatelessWidget {
  const CommodityItem({super.key, required this.data});
  final CommodityModel data;
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    return Material(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Ink(
          width: 148,
          height: 56,
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.neutral_07,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      data.nAME ?? "",
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
