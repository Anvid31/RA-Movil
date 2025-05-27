import 'package:flutter/material.dart';
import '../views/login_view.dart';
import '../views/home_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String initial = login;

  static Map<String, Widget Function(BuildContext)> get routes => {
    login: (context) => const LoginView(),
    home: (context) => const HomeView(),
  };
} 