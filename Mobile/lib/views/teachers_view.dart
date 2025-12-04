import 'package:flutter/material.dart';
import '../widgets/navbar/custom_navbar.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_input.dart';
import '../widgets/primary_button.dart';

class TeachersView extends StatefulWidget {
  const TeachersView({super.key});

  @override
  State<TeachersView> createState() => _TeachersViewState();
}

class _TeachersViewState extends State<TeachersView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: CustomNavbar(scaffoldKey: scaffoldKey),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registro de Docentes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                SizedBox(height: 30),
                CustomInput(
                  label: "Nombre Completo",
                  controller: _nameController,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Este campo es requerido' : null,
                ),
                SizedBox(height: 20),
                CustomInput(
                  label: "Identificación",
                  controller: _idController,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Este campo es requerido' : null,
                ),
                SizedBox(height: 20),
                CustomInput(
                  label: "Correo Electrónico",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Este campo es requerido';
                    }
                    if (!value!.contains('@')) {
                      return 'Ingrese un correo válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomInput(
                  label: "Teléfono",
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Este campo es requerido' : null,
                ),
                SizedBox(height: 40),
                Center(
                  child: PrimaryButton(
                    text: "Registrar Docente",
                    isLoading: _isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Aquí iría la lógica para registrar el docente
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
