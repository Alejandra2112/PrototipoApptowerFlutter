import 'package:apptower/ScreenViews/usuarios.dart';
import 'package:apptower/widgets/inputs/inputs_form.dart';
import 'package:apptower/widgets/inputs/inputs_formS.dart';
import 'package:flutter/material.dart';
import 'package:apptower/Models/Data.dart';
import 'package:intl/intl.dart';

class RegistrarUsuarioVista extends StatefulWidget {
  RegistrarUsuarioVista({super.key});

  @override
  State<RegistrarUsuarioVista> createState() => _ModalRegistrarUsuariosState();
}

class _ModalRegistrarUsuariosState extends State<RegistrarUsuarioVista> {
  final registro = ModulosData();

  late String SeleccionTD = 'CC';
  late bool estado = true;
  late String dropdownValue = 'Residente';
  final TextEditingController _documento = TextEditingController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _apellido = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();
  final TextEditingController _contrasenaC = TextEditingController();
  List<String> roles = ['Administrador', 'Residente', 'Vigilante'];

  List<String> Td = ['CC', 'CE'];
  List<String> Est = ['Activo', 'Inactivo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Usuario"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputsFormS(
                  obscureText: false,
                  hintext: 'Ingrese su Nombre',
                  labelText: 'Nombre',
                  controller: _nombre),
              InputsFormS(
                  obscureText: false,
                  hintext: 'Ingrese su Apellido',
                  labelText: 'Apellido',
                  controller: _apellido),
              SizedBox(
                height: 6,
              ),
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
              SizedBox(
                height: 6,
              ),
              InputsForm(
                  controller: _documento,
                  obscureText: false,
                  hintext: 'Ingrese su Documento',
                  labelText: 'Documento'),
              InputsFormS(
                  obscureText: false,
                  hintext: 'Ingrese su Correo',
                  labelText: 'Correo',
                  controller: _correo),
              InputsForm(
                  controller: _telefono,
                  obscureText: false,
                  hintext: 'Ingrese su Teléfono',
                  labelText: 'Teléfono'),
              InputsForm(
                  controller: _contrasena,
                  obscureText: true,
                  hintext: 'Ingrese su Teléfono',
                  labelText: 'Contraseña'),
              InputsForm(
                  controller: _contrasenaC,
                  obscureText: true,
                  hintext: 'Ingrese su Teléfono',
                  labelText: 'Confirmar Contraseña'),
              SizedBox(
                height: 6,
              ),
              DropdownButtonFormField<String>(
                value: dropdownValue,
                items: roles.map((String roles) {
                  return DropdownMenuItem<String>(
                    value: roles,
                    child: Text(roles),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null && Td.contains(newValue)) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Roles',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 9,
              ),
              DropdownButtonFormField<bool>(
                value: estado,
                items: Est.map((String est) {
                  return DropdownMenuItem<bool>(
                    value: est == 'Activo',
                    child: Text(est),
                  );
                }).toList(),
                onChanged: (bool? newValue) {
                  if (newValue != null) {
                    setState(() {
                      estado = newValue;
                    });
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_contrasena.text != _contrasenaC.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Las contraseñas no son iguales'),
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
                      "rol": dropdownValue,
                      "estado": estado,
                      "fecha": DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(DateTime.now()),
                      "password": _contrasena.text,
                    };

                    try {
                      await registro.agregarRegistro(
                          nuevoUsuario, 'usuarios/usuarios');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Se agregó el registro correctamente'),
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Usuarios()),
                      );
                    } catch (e) {
                      print('Error al agregar$e');
                    }
                  }
                },
                child: Text('Guardar'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(0, 26, 78, 1)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancelar",
                  style: TextStyle(
                    fontSize: 15,
                    decoration: TextDecoration.none,
                    color: Color.fromARGB(255, 0, 0, 46),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
