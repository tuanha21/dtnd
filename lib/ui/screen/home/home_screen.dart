import 'package:dtnd/ui/screen/home/widget/asset_card.dart';
import 'package:dtnd/ui/screen/home/widget/home_quick_access.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "DTND"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          HomeAssetCard(),
          HomeQuickAccess(),
        ],
      ),
    );
  }
}
