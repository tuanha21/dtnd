import 'dart:async';

import 'package:dtnd/=models=/side.dart';
import 'package:flutter/material.dart';

typedef FutureVoidCallback = Future<void> Function();
typedef OnTextFormFieldChanged = void Function(
    FormFieldState<String?>? state, String value);

typedef OnSocket = dynamic Function(dynamic);
typedef OnRegisteredCode = FutureOr<void> Function(String);
typedef OnAsyncButtonPressed = Future<void> Function();
typedef GetTotalVol = num Function(Side);

typedef ColorOnThemeMode = Color Function(ThemeMode themeMode);
typedef IsActive = bool Function();
