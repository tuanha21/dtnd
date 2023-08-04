import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/accumulation.dart';
import 'package:dtnd/ui/screen/ekyc/page/ekyc_introduce_page.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../config/service/app_services.dart';
import '../logic/function_data.dart';

class ListFunction extends StatefulWidget {
  const ListFunction({super.key, required this.list, this.drawerRebuild});

  final List<FunctionData> list;
  final VoidCallback? drawerRebuild;

  @override
  State<ListFunction> createState() => _ListFunctionState();
}

class _ListFunctionState extends State<ListFunction> {
  @override
  void initState() {
    super.initState();
  }

  void _onTapBigTitle(FunctionData item) {
    if (item.title == 'Tích luỹ') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Accumlation(),
      ));
      return;
    } else if (item.title == 'Xác thực tài khoản - eKYC') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const EkycIntroducePage(),
      ));
      return;
    } else if (item.subTitle!.isEmpty == true) {
      onDeveloping();
      return;
    }
  }

  void onDeveloping() {
    Fluttertoast.showToast(
      msg: S.of(context).developing_feature,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        var item = widget.list[index];
        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            onExpansionChanged: (bool isExpanded) => _onTapBigTitle(item),
            iconColor: AppColors.text_black_1,
            tilePadding: const EdgeInsets.only(left: 4),
            leading: Image.asset(
              item.iconPath!,
              height: 24,
              width: 24,
              fit: BoxFit.cover,
            ),
            title: Container(
              padding: EdgeInsets.zero,
              child: Text(
                item.title,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            trailing: item.subTitle!.isEmpty
                ? const SizedBox.shrink()
                : const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.neutral_01,
                  ),
            children: [
              if (item.subTitle?.isNotEmpty ?? false)
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(left: 21),
                    shrinkWrap: true,
                    itemCount: item.subTitle!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => item.subTitle![index].function!.call(),
                        child: Container(
                          padding: const EdgeInsets.only(left: 40, bottom: 10),
                          height: 40,
                          child: Text(
                            item.subTitle![index].title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: themeMode.isLight
                                        ? AppColors.neutral_02
                                        : AppColors.neutral_07),
                          ),
                        ),
                      );
                    },
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
