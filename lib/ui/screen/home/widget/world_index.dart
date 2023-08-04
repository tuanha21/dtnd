import 'package:dtnd/=models=/response/world_index_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeWorldIndexItem extends StatelessWidget {
  const HomeWorldIndexItem(
      {super.key, required this.data, this.selectedSymbol, this.onSelected});

  final WorldIndexModel data;
  final int? selectedSymbol;
  final ValueChanged<WorldIndexModel>? onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final themeMode = AppService.instance.themeMode.value;

    BoxBorder? border;
    if (selectedSymbol != null && data.iDSYMBOL == selectedSymbol) {
      border = Border.all(color: AppColors.neutral_04);
    }
    VoidCallback? onTap;
    if (onSelected != null) {
      onTap = () {
        print(data.iDSYMBOL);
        onSelected?.call(data);
      };
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Ink(
          width: 148,
          height: 60,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: border,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: themeMode.isLight
                ? AppColors.neutral_07
                : AppColors.text_black_1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox.square(
                    dimension: 15,
                    child: SvgPicture.asset(
                      'assets/images/${data.iDSYMBOL}.svg',
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    data.nAME ?? "",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: themeMode.isLight
                            ? AppColors.text_black_1
                            : AppColors.neutral_07),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    NumUtils.formatDouble(data.lASTPOINT),
                    style: AppTextStyle.labelMedium_12.copyWith(
                      fontWeight: FontWeight.w600,
                      color: data.cOLOR,
                    ),
                  ),
                  Text(
                    "(${data.pERCENTCHANGE})",
                    style: AppTextStyle.bodySmall_8.copyWith(
                      fontWeight: FontWeight.w600,
                      color: data.cOLOR,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    data.cHANGE ?? "0",
                    style: AppTextStyle.labelMedium_12.copyWith(
                      fontWeight: FontWeight.w600,
                      color: data.cOLOR,
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
