import 'package:flutter/material.dart';
import 'package:uniprep/app/theme/app_theme.dart';
import 'package:uniprep/auth/loginScreen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      home: const LoginScreen(),
    );
  }
}