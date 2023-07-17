import 'package:dtnd/ui/screen/community/widget/premium_widget/premium_item.dart';
import 'package:dtnd/ui/screen/community/widget/premium_widget/premium_post_group.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/i_local_storage_service.dart';
import '../../../data/i_user_service.dart';
import '../../../data/implementations/local_storage_service.dart';
import '../../../data/implementations/user_service.dart';
import '../market/widget/components/not_signin_catalog_widget.dart';

class PremiumTab extends StatefulWidget {
  const PremiumTab({Key? key}) : super(key: key);

  @override
  State<PremiumTab> createState() => _PremiumTabState();
}

class _PremiumTabState extends State<PremiumTab>
    with AutomaticKeepAliveClientMixin {
  final IUserService userService = UserService();
  final ILocalStorageService localStorageService = LocalStorageService();

  void rebuild() => setState(() {
        initState();
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (userService.token.value == null) {
          return Center(
            child: NotSignInCatalogWidget(
              afterLogin: rebuild,
              localStorageService: localStorageService,
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: AppColors.neutral_05,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nhóm có nội dung Premium",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          PremiumItem(),
                          PremiumItem()
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                PremiumPostGroup(),
                PremiumPostGroup(),
                PremiumPostGroup(),
              ],
            ),
          );
        }
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
