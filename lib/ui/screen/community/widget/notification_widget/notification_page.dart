import 'package:dtnd/ui/screen/community/widget/notification_widget/widget/all_page.dart';
import 'package:dtnd/ui/screen/community/widget/notification_widget/widget/community_page.dart';
import 'package:dtnd/ui/screen/community/widget/notification_widget/widget/notification_page.dart';
import 'package:dtnd/ui/screen/community/widget/notification_widget/widget/transaction_page.dart';
import 'package:dtnd/ui/screen/community/widget/notification_widget/widget/volatility_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../l10n/generated/l10n.dart';
import '../../../../theme/app_image.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late List<bool> _isCheckedList = [true, false, false, false, false];

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông tin IFIS",
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist),
            onPressed: _showConfirmationDialog,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              isScrollable: true,
              indicator: const BoxDecoration(),
              labelPadding: const EdgeInsets.symmetric(vertical: 5),
              tabs: <Widget>[
                _buildTabTitle('Tất cả', 0),
                _buildTabTitle('Giao dịch', 1),
                _buildTabTitle('Biến động', 2),
                _buildTabTitle('Cộng đồng', 3),
                _buildTabTitle('Thông báo', 4),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  AllPage(),
                  CommunityPage(),
                  NotificationPage(),
                  TransactionPage(),
                  VolatilityPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTabTitle(String title, int index) {
    bool isChecked = _isCheckedList[index];
    return InkWell(
      onTap: () {
        setState(() {
          _onTabHeaderTap(index);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isChecked ? Colors.blue : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: isChecked ? Colors.white : Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _onTabHeaderTap(int index) {
    setState(() {
      _isCheckedList = List.generate(5, (i) => i == index);
    });
    _tabController.animateTo(index);
  }

  void _showConfirmationDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final ThemeData themeData = Theme.of(context);
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: themeData.colorScheme.background,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: themeData.colorScheme.onBackground,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  AppImages.circleAlert,
                  height: 150,
                  width: 50,
                ),
                const SizedBox(height: 20),
                Text(S.of(context).mark_as_read),
                const SizedBox(height: 10),
                Text(S
                    .of(context)
                    .all_notifications_in_the_notifications_section),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            S.of(context).abort,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue),
                            color: Colors.blue,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            S.of(context).confirm,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
