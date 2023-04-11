import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/drawer/component/list_function.dart';
import 'package:dtnd/ui/widget/drawer/logic/function_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/app_image.dart';

class AppDrawerSubView extends StatefulWidget {
  const AppDrawerSubView({super.key, required this.list, required this.title});

  final List<FunctionData> list;
  final String title;

  @override
  State<AppDrawerSubView> createState() => _AppDrawerStateSubView();
}

class _AppDrawerStateSubView extends State<AppDrawerSubView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, right: 16, left: 16),
      decoration: const BoxDecoration(color: Colors.white),
      // width: 275,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 23,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                child: SvgPicture.asset(AppImages.back_draw_icon),
                onTap: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 16,),
              Text(widget.title,style: AppTextStyle.titleLarge_18,)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(child: ListFunction(list: widget.list)),
        ],
      ),
    );
  }
}
