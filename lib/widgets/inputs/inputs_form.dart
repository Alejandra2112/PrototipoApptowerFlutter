import 'package:flutter/material.dart';

class InputsForm extends StatelessWidget {
  final bool obscureText;
  final String hintext;
  final String labelText;
  final Icon? icon;
  final TextEditingController controller;

  const InputsForm({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.hintext,
    required this.labelText,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      margin: EdgeInsets.only(top: 0),
      child: TextFormField(
        controller: controller,
        autofocus: true,
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintext,
          labelText: labelText,
          prefixIcon: icon,
          
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0), // Puedes ajustar el radio según tus preferencias
          ),
        ),
      ),
    );
  }
}
