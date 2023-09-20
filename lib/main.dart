import 'package:apptower/ScreenViews/inicio.dart';
import 'package:apptower/ScreenViews/login.dart';
import 'package:apptower/ScreenViews/usuarios.dart';
import 'package:apptower/themes/appThemes.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

   @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LogIn(),
      theme: AppTheme.customTheme, 
    );
  }
}
