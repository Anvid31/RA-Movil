import 'package:flutter/material.dart';
import '../widgets/custom_input.dart';
import '../widgets/primary_button.dart';
import '../widgets/curved_background.dart';
import '../theme/app_theme.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Para propósitos de demostración, podemos pre-llenar el campo
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su usuario';
    } 
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su contraseña';
    }
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simular una operación de inicio de sesión
      Future.delayed(Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        // Aquí iría la implementación real de autenticación
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inicio de sesión exitoso')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const CurvedBackground(),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo FESC - Idealmente debería ser una imagen vectorial
                      Center(
                        child: Column(
                          children: [
                            // Aquí usamos un Row para tener "FESC" con la C en rojo
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'FES',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textColor,
                                    letterSpacing: -1,
                                  ),
                                ),
                                Text(
                                  'C',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'EDUCACIÓN SUPERIOR',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textColor,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 5),
                            // Logo Comfanorte
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: AppTheme.primaryColor,
                                  size: 15,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Comfanorte',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.primaryColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),
                      CustomInput(
                        label: "Usuario",
                        controller: _usernameController,
                        validator: _validateUsername,
                      ),
                      const SizedBox(height: 30),
                      CustomInput(
                        label: "Contraseña",
                        obscure: true,
                        controller: _passwordController,
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: PrimaryButton(
                          text: "Iniciar Sesión",
                          onPressed: _handleLogin,
                          isLoading: _isLoading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}