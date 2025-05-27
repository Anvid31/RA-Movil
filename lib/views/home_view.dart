import 'package:flutter/material.dart';
import '../widgets/navbar/custom_navbar.dart';
import '../widgets/dashboard/dashboard_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomNavbar(),
      body: SingleChildScrollView(
        child: DashboardContainer(),
      ),
    );
  }
} 