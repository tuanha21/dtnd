import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/exercise_right/tab/purchase_rights_history_tab.dart';
import 'package:dtnd/ui/screen/exercise_right/tab/registration_rights_tab.dart';
import 'package:dtnd/ui/screen/exercise_right/tab/rights_info_tab.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';

class ExerciseRightScreen extends StatefulWidget {
  const ExerciseRightScreen({super.key, this.defaultTab = 0});

  final int defaultTab;

  @override
  State<ExerciseRightScreen> createState() => _ExerciseRightScreenState();
}

class _ExerciseRightScreenState extends State<ExerciseRightScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      tabController.animateTo(widget.defaultTab);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).exercise_right,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Divider(),
            const SizedBox(
              height: 5,
            ),
            TabBar(
              controller: tabController,
              isScrollable: true,
              labelStyle: textTheme.titleSmall,
              // labelPadding:
              //     const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              tabs: [
                Text(
                  S.of(context).permission_information,
                  style: AppTextStyle.titleSmall_14.copyWith(height: 1.5),
                  textAlign: TextAlign.center,
                ),
                Text(
                  S.of(context).register_the_right_to_buy,
                  style: AppTextStyle.titleSmall_14.copyWith(height: 1.5),
                  textAlign: TextAlign.center,
                ),
                Text(
                  S.of(context).purchase_rights_history,
                  style: AppTextStyle.titleSmall_14.copyWith(height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const [
                RightsInfoTab(),
                RegisterTheRightToBuyTab(),
                PurchaseRightsHistoryTab(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
