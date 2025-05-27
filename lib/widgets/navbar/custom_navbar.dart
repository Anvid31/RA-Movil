import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              backgroundColor: AppTheme.primaryColor,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  // Logo FESC
                  Image.asset(
                    'lib/assets/logo_fesc_white.png',
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  Spacer(),
                  // Menú desplegable
                  PopupMenuButton<String>(
                    icon: Icon(Icons.menu, color: Colors.white),
                    onSelected: (String value) {
                      if (value == 'cerrar_sesion') {
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'perfil',
                        child: Text('Perfil'),
                      ),
                      PopupMenuItem<String>(
                        value: 'configuracion',
                        child: Text('Configuración'),
                      ),
                      PopupMenuItem<String>(
                        value: 'cerrar_sesion',
                        child: Text('Cerrar Sesión'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  // Barra de búsqueda
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextField(
                        style: TextStyle(fontSize: 14),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Buscar...',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 20,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 40,
                            minHeight: 40,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Icono de notificaciones
                  Stack(
                    children: [
                      IconButton(
                        icon: Icon(Icons.notifications, color: Colors.grey[700]),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  // Icono de ayuda
                  IconButton(
                    icon: Icon(Icons.help_outline, color: Colors.grey[700]),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
} 