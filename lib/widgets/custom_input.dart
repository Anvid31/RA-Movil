import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final bool obscure;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final String? initialValue;

  const CustomInput({
    super.key,
    required this.label,
    required this.controller,
    this.obscure = false,
    this.hintText = '',
    this.validator,
    this.keyboardType = TextInputType.text,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    if (initialValue != null && controller.text.isEmpty) {
      controller.text = initialValue!;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none, // Quitamos el borde por defecto
            contentPadding: EdgeInsets.only(top: 8, bottom: 8),
            isDense: true,
            // Si es contraseña y tiene texto, mostramos asteriscos en lugar del texto real
            hintStyle: TextStyle(color: Colors.black38),
          ),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium!.color,
            fontSize: 16,
          ),
          obscuringCharacter: '●', // Carácter para ocultar la contraseña
        ),
      ],
    );
  }
}