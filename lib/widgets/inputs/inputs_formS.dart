import 'package:flutter/material.dart';

class InputsFormS extends StatelessWidget {
   final bool obscureText;
  final String hintext;
  final String labelText;
  final Icon? icon;
   final TextEditingController controller;
const InputsFormS({ Key? key, required this.obscureText, required this.hintext, required this.labelText, this.icon, required this.controller }) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      margin: EdgeInsets.only(top: 0),
      child: TextFormField(
        controller: controller,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        obscureText: obscureText,
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Este campo es requerido';
  } else {
    String parsedValue = value.toString();
    if (parsedValue.isEmpty) {
      return 'Ingrese un texto';
    } else if (int.tryParse(parsedValue) != null) {
      return 'No puede ser un número';
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
              color: Colors.black, // Cambia el color del borde a negro cuando está enfocado
            )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0), // Puedes ajustar el radio según tus preferencias
          ),
          
        )
    
      ),
    );
  }
  
}