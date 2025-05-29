import 'package:flutter/material.dart';

import '../widgets/curved_background.dart';
import '../widgets/custom_input.dart';
import '../widgets/primary_button.dart';

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
        // Navegamos a la vista de inicio
        Navigator.pushReplacementNamed(context, '/home');
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
                      // Logo FESC
                      Center(
                        child: Container(
                          height: 120,
                          child: Image.asset(
                            'lib/assets/logo_fesc.png',
                            fit: BoxFit.contain,
                          ),
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
