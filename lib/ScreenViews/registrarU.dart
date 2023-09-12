import 'package:apptower/ScreenViews/login.dart';
import 'package:apptower/widgets/inputs/inputs_form.dart';
import 'package:apptower/widgets/inputs/inputs_formS.dart';
import 'package:flutter/material.dart';
import 'package:apptower/themes/theme.dart';
import 'package:apptower/Models/Data.dart';

class RegistarU extends StatefulWidget {
  const RegistarU({Key? key}) : super(key: key);

  @override
  _RegistarUState createState() => _RegistarUState();
}

class _RegistarUState extends State<RegistarU> {
  final registro = ModulosData();
  late String SeleccionTD = 'CC';
  List<String> Td = ['CC', 'CE'];

  final TextEditingController _documento = TextEditingController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _apellido = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();
  final TextEditingController _contrasenaC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // backgroundColor: const Color.fromRGBO(248, 249, 250, 1),
        body: Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
              height: 190,
              child:
                  Image.network( "../img/Logo-Apptower.png")),
          Padding(
            padding: AppTheme.selectPading,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: SeleccionTD,
                  items: Td.map((String td) {
                    return DropdownMenuItem<String>(
                      value: td,
                      child: Text(td),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null && Td.contains(newValue)) {
                      setState(() {
                        SeleccionTD = newValue;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Tipo de Documento',
                    border: OutlineInputBorder(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: InputsForm(
                        controller: _documento,
                        obscureText: false,
                        hintext: 'Ingrese su Documento',
                        labelText: 'Documento'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: InputsFormS(
                        obscureText: false,
                        hintext: 'Ingrese su Nombre',
                        labelText: 'Nombre',
                        controller: _nombre),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: InputsFormS(
                        obscureText: false,
                        hintext: 'Ingrese su Apellido',
                        labelText: 'Apellido',
                        controller: _apellido),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: InputsFormS(
                        obscureText: false,
                        hintext: 'Ingrese su Correo',
                        labelText: 'Correo',
                        controller: _correo),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: InputsForm(
                        controller: _telefono,
                        obscureText: false,
                        hintext: 'Ingrese su Teléfono',
                        labelText: 'Teléfono'),
                  ),
                ),
               
                const SizedBox(height: 20),
                Padding(
                  padding: AppTheme.selectPading,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppTheme.ApptowerBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      elevation: 4.0,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () async {
                      if (_documento.text == '' ||
                          _contrasena.text == '' ||
                          _contrasenaC.text == '' ||
                          _nombre.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Campos Vacíos"),
                          ),
                        );
                      } else {
                        final Map<String, dynamic> nuevoUsuario = {
                          "tipo_documento": SeleccionTD,
                          "documento": int.parse(_documento.text),
                          "nombre": _nombre.text,
                          "apellido": _apellido.text,
                          "correo": _correo.text,
                          "telefono": int.parse(_telefono.text),
                          "rol": 'Residente',
                          "estado": true,
                          "fecha": DateTime.now().toIso8601String(),
                          "password": _contrasena.text,
                        };

                        try {
                          await registro.agregarRegistro(
                              nuevoUsuario, 'usuarios/usuarios');

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Se agregó el registro correctamente'),
                            ),
                          );
                          Navigator.of(context).pop();
                        } catch (e) {
                          print('Error al agregar $e');
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogIn()),
                        );
                      }
                    },
                    child: const Text("Registrar"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LogIn(),
                      ),
                    );
                  },
                  child: const Text(
                    "Regresar",
                    style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(255, 13, 13, 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
