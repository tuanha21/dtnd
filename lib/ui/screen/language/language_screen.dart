import 'package:flutter/material.dart';

import '../../../config/service/app_services.dart';
import '../../../data/i_local_storage_service.dart';
import '../../../data/implementations/local_storage_service.dart';
import '../../../generated/l10n.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  late Color _backgroundColor = Colors.red;
  late AppService appService = AppService();

  final ILocalStorageService localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    final String? selectedLanguage =
        localStorageService.sharedPreferences.getString(languageKey);
    if (selectedLanguage != null) {
      setState(
        () {
          _backgroundColor =
              (selectedLanguage == 'vi') ? Colors.red : Colors.green;
        },
      );
    }
  }

  void _setBackgroundColor(Color? color) {
    setState(() {
      _backgroundColor = color!;
    });
  }

  Future<void> _saveSelectedLanguage(String languageCode) async {
    localStorageService.saveLanguage(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).languges,
          style: TextStyle(
            color: themeData.colorScheme.onBackground,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          _buildLanguageOption(
            context,
            'Tiếng Việt',
            Colors.red,
            _backgroundColor,
            'vi',
          ),
          _buildLanguageOption(
            context,
            'Tiếng Anh',
            Colors.green,
            _backgroundColor,
            'en',
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String label,
    Color value,
    Color groupValue,
    String languageCode,
  ) {
    final isSelected = value == groupValue;

    return InkWell(
      onTap: () async {
        await appService.switchLanguage();
        await _saveSelectedLanguage(languageCode);
        _setBackgroundColor(value);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(color: isSelected ? Colors.white : Colors.blue),
            ),
            Radio(
              value: value,
              groupValue: groupValue,
              onChanged: (value) async {
                await appService.switchLanguage();
                await _saveSelectedLanguage(languageCode);
                _setBackgroundColor(value);
              },
              activeColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
