import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/ui/screen/search/search_screen.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.title,
    this.onSearched,
    this.showActions = true,
  });
  final String title;
  final ValueChanged<Stock?>? onSearched;
  final bool showActions;
  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: widget.showActions
          ? [
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ));
                  },
                  child: Ink(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: SvgPicture.asset(AppImages.search_appbar_icon),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset(AppImages.notification_appbar_icon),
              const SizedBox(
                width: 16,
              ),
            ]
          : [],
    );
  }
}
