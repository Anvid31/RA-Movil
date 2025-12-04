import 'package:flutter/material.dart';

import '../widgets/dashboard/dashboard_container.dart';
import '../widgets/navbar/custom_navbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: CustomNavbar(scaffoldKey: scaffoldKey),
      endDrawer: const CustomDrawer(),
      // Usamos SingleChildScrollView para permitir el desplazamiento
      // en caso de que el contenido sea más grande que la pantalla
      body: const SingleChildScrollView( 
        child: DashboardContainer(),
      ),
    );
  }
}
