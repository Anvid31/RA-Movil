import 'package:flutter/material.dart';
import '../widgets/navbar/custom_navbar.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_input.dart';
import '../widgets/primary_button.dart';

class ProgramsView extends StatefulWidget {
  const ProgramsView({super.key});

  @override
  State<ProgramsView> createState() => _ProgramsViewState();
}

class _ProgramsViewState extends State<ProgramsView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _durationController = TextEditingController();
  final _levelController = TextEditingController();
  final bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _durationController.dispose();
    _levelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomNavbar(scaffoldKey: scaffoldKey),
      key: scaffoldKey,
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registro de Programas Académicos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                const SizedBox(height: 30),
                CustomInput(
                  label: "Nombre del Programa",
                  controller: _nameController,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Este campo es requerido' : null,
                ),
                const SizedBox(height: 20),
                CustomInput(
                  label: "Código del Programa",
                  controller: _codeController,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Este campo es requerido' : null,
                ),
                const SizedBox(height: 20),
                CustomInput(
                  label: "Duración (semestres)",
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Este campo es requerido' : null,
                ),
                const SizedBox(height: 20),
                CustomInput(
                  label: "Nivel de Formación",
                  controller: _levelController,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Este campo es requerido' : null,
                ),
                const SizedBox(height: 40),
                Center(
                  child: PrimaryButton(
                    text: "Registrar Programa",
                    isLoading: _isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Aquí iría la lógica para registrar el programa
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
