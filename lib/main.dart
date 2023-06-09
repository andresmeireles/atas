import 'package:atas/App.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final delegate = await LocalizationDelegate.create(
    // basePath: 'assets/i18n/',
    fallbackLocale: 'en_US',
    supportedLocales: ['pt', 'en_US'],
  );
  runApp(LocalizedApp(delegate, const App()));
}
