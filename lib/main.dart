import 'package:flutter/material.dart';
import 'package:todoappv0/4_presentation/home/home_page.dart';
import 'package:todoappv0/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      title: 'Todo App',
      home: const HomePage(),
    );
  }
}
