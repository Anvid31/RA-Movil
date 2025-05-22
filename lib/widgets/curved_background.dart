import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CurvedBackground extends StatelessWidget {
  const CurvedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: 70,
      height: height,
      child: CustomPaint(
        painter: _CurvePainter(),
        size: Size(70, height),
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint redPaint = Paint()..color = AppTheme.primaryColor;
    
    // Creamos el path para la parte curva roja
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.7, 0);
    
    // Curva principal que va desde arriba hasta abajo
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.2,  // punto de control
      size.width * 0.9, size.height * 0.3,   // punto final
    );
    
    path.quadraticBezierTo(
      size.width * 1.2, size.height * 0.5,  // punto de control
      size.width * 0.9, size.height * 0.7,   // punto final
    );
    
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.8,  // punto de control
      size.width * 0.7, size.height,        // punto final
    );
    
    path.lineTo(0, size.height);
    path.close();
    
    canvas.drawPath(path, redPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}