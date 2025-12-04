import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FESC RA App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
    );
  }
}
