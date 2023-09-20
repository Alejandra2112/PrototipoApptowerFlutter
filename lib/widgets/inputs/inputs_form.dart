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
              validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Este campo es requerido';
  } else {
    double? parsedValue = double.tryParse(value);
    if (parsedValue == null) {
      return 'Ingrese un valor numérico válido';
    } else if (parsedValue <= 0) {
      return 'El valor debe ser mayor que cero';
    }
  }
  return null; 
},
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintext,
          labelText: labelText,
          prefixIcon: icon,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
