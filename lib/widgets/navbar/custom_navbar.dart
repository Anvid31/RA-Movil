import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomNavbar({
    super.key,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.primaryColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset(
            'lib/assets/logo_fesc_white.png',
            height: 40,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // Animación para el Drawer
      curve: Curves.easeInOut,
      // Duración de la animación
      duration: const Duration(milliseconds: 300),

      width: MediaQuery.of(context).size.width * 0.6,

      child: Drawer(
        backgroundColor: AppTheme.primaryColor,
        child: Container(
          color: AppTheme.primaryColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FESC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'EDUCACIÓN SUPERIOR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              _buildMenuItem(
                icon: Icons.home,
                title: 'Inicio',
                onTap: () => Navigator.pushNamed(context, '/home'),
              ),

              _buildMenuItem(
                icon: Icons.book,
                title: 'Registrar RA',
                onTap: () => Navigator.pushNamed(context, '/programs-list'),
              ),
              _buildMenuItem(
                icon: Icons.dashboard,
                title: 'Dashboard Usuarios',
                onTap: () {},
              ),
              ExpansionTile(
                leading: const Icon(Icons.person_add, color: Colors.white),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: const Text(
                  'Registro',
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  _buildSubMenuItem(
                    icon: Icons.person,
                    title: 'Docentes',
                    onTap: () => Navigator.pushNamed(context, '/teachers'),
                  ),
                  _buildSubMenuItem(
                    icon: Icons.book,
                    title: 'Programa Académico',
                    onTap: () => Navigator.pushNamed(context, '/programs'),
                  ),
                ],
              ),
              _buildMenuItem(
                icon: Icons.bar_chart,
                title: 'Reportes',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.settings,
                title: 'Configuración',
                onTap: () {},
              ),
              const Divider(color: Colors.white54),
              const Spacer(),
              // Información del usuario
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: const CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: const Text(
                  'Admin',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'Cerrar sesión',
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () => Navigator.pushReplacementNamed(context, '/login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      shape: const Border(
        bottom: BorderSide(color: Colors.white24, width: 0.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      tileColor: Colors.transparent,
      hoverColor: Colors.white24,
      selectedTileColor: Colors.white30,
      selected: false,
      // Cambia el color de fondo al seleccionar
      iconColor: Colors.white,
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  Widget _buildSubMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      contentPadding: const EdgeInsets.only(left: 72),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}
