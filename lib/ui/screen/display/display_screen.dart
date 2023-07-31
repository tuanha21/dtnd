import 'package:dtnd/config/service/app_services.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({Key? key}) : super(key: key);

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  bool nightMode = false;
  final AppService appService = AppService();

  late ThemeMode themeMode;

  @override
  void initState() {
    themeMode = appService.currentTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).interface,
          style: TextStyle(
              color: themeData.colorScheme.onBackground,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: themeData.colorScheme.background),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).night_mode,
                  style: TextStyle(
                      color: themeData.colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Switch(
                  value: themeMode == ThemeMode.dark,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    setState(
                      () {
                        appService.switchTheme();
                        setState(
                          () {
                            themeMode = appService.currentTheme;
                          },
                        );
                      },
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
