import 'package:flutter/material.dart';
import '../views/login_view.dart';
import '../views/home_view.dart';
import '../views/teachers_view.dart';
import '../views/programs_view.dart';
import '../views/programs_list_view.dart';
import '../views/subjects_view.dart';
import '../views/periods_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String teachers = '/teachers';
  static const String programs = '/programs';
  static const String programsList = '/programs-list';
  static const String subjects = '/subjects';
  static const String periods = '/periods';
  static const String initial = login;

  static Map<String, Widget Function(BuildContext)> get routes => {
        login: (context) => const LoginView(),
        home: (context) => const HomeView(),
        teachers: (context) => const TeachersView(),
        programs: (context) => const ProgramsView(),
        programsList: (context) => const ProgramsListView(),
        subjects: (context) => const SubjectsView(),
        periods: (context) => const PeriodsView(programName: ''), // Este constructor solo es para la definición de rutas

      };
}
