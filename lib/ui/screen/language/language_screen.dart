import 'package:flutter/material.dart';

import '../../../config/service/app_services.dart';
import '../../../generated/l10n.dart';
import '../../theme/app_color.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  late Color _backgroundColor ;
  late AppService appService = AppService();
  final ThemeMode themeMode = AppService.instance.themeMode.value;

  @override
  void initState() {
    super.initState();
    _backgroundColor =
    (appService.locale.value.languageCode == 'vi') ? Colors.red : Colors.green;
  }

  void _setBackgroundColor(Color? color) {
    setState(() {
      _backgroundColor = color!;
    });
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeMode.isLight ? AppColors.neutral_07 : AppColors.text_black_1,
        title: Text(
          S.of(context).languge,
          style: TextStyle(
            color: themeData.colorScheme.onBackground,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: themeMode.isLight ? AppColors.neutral_07 : AppColors.text_black_1,
        child: Column(
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
    final ThemeData themeData = Theme.of(context);

    return InkWell(
      onTap: () async {
        await appService.switchLanguage();
        _setBackgroundColor(value);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? themeMode.isLight ? AppColors.neutral_07 : AppColors.text_black_1 : themeMode.isLight ? AppColors.neutral_07  : AppColors.text_black_1,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              label,
              style:  TextStyle(color: themeMode.isLight ? AppColors.text_black_1 : AppColors.neutral_07),
            ),
            Radio(
              value: value,
              groupValue: groupValue,
              onChanged: (value) async {
                await appService.switchLanguage();
                _setBackgroundColor(value);
              },
              activeColor: Colors.white,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              fillColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return AppColors.color_secondary;
                  } else {
                    return AppColors.neutral_03;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
