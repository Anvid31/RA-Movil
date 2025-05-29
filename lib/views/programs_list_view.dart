import 'package:flutter/material.dart';
import '../widgets/navbar/custom_navbar.dart';
import '../theme/app_theme.dart';
import 'periods_view.dart';

class ProgramsListView extends StatelessWidget {
  const ProgramsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    
    // Lista temporal de programas (esto después vendrá de la API)
    final programs = [
      {'name': 'Ingenieria de Software', 'icon': Icons.computer},
      {'name': 'Administracion Financiera', 'icon': Icons.attach_money},
      {'name': 'Gestion Logistica Empresarial', 'icon': Icons.local_shipping},
      {'name': 'Diseño y Administracion de Negocios de la Moda', 'icon': Icons.design_services},
      {'name': 'Administracion de Negocios Internacionales', 'icon': Icons.business},
      {'name': 'Administracion Turistica y Hotelera', 'icon': Icons.hotel},
    ];

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: CustomNavbar(scaffoldKey: scaffoldKey),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Programas Academicos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
              ),
              ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: programs.length,
  itemBuilder: (context, index) {
    return _buildProgramItem(
      programs[index]['name'] as String,
      programs[index]['icon'] as IconData,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PeriodsView(
              programName: programs[index]['name'] as String,
            ),
          ),
        );
      },
    );
  },
),
              _buildAddButton(context),
            ],
          ),
        ),
      ),
    );
  }

// En programs_list_view.dart, actualiza el método _buildProgramItem:
Widget _buildProgramItem(String name, IconData icon, {required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // Aumentado el padding vertical
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12), // Aumentado el padding del icono
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12), // Aumentado el radio
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 32, // Icono más grande
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 18, // Texto más grande
                fontWeight: FontWeight.w500,
                color: AppTheme.textColor,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    ),
  );
}

  Widget _buildAddButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/programs');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('Nuevo'),
          ],
        ),
      ),
    );
  }
}