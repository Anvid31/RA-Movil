import 'package:flutter/material.dart';
import '../widgets/navbar/custom_navbar.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_input.dart';
import '../widgets/primary_button.dart';

class SubjectsView extends StatefulWidget {
  const SubjectsView({super.key});

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _creditsController = TextEditingController();
  final _programController = TextEditingController();
  final bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _creditsController.dispose();
    _programController.dispose();
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
                  'Registro de Materias',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                SizedBox(height: 30),
                CustomInput(
                  label: "Nombre de la Materia",
                  controller: _nameController,
                  validator: (value) => value?.isEmpty ?? true 
                    ? 'Este campo es requerido' : null,
                ),
                SizedBox(height: 20),
                CustomInput(
                  label: "Código de la Materia",
                  controller: _codeController,
                  validator: (value) => value?.isEmpty ?? true 
                    ? 'Este campo es requerido' : null,
                ),
                SizedBox(height: 20),
                CustomInput(
                  label: "Créditos",
                  controller: _creditsController,
                  keyboardType: TextInputType.number,
                  validator: (value) => value?.isEmpty ?? true 
                    ? 'Este campo es requerido' : null,
                ),
                SizedBox(height: 20),
                CustomInput(
                  label: "Programa Académico",
                  controller: _programController,
                  validator: (value) => value?.isEmpty ?? true 
                    ? 'Este campo es requerido' : null,
                ),
                SizedBox(height: 40),
                Center(
                  child: PrimaryButton(
                    text: "Registrar Materia",
                    isLoading: _isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Aquí iría la lógica para registrar la materia
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