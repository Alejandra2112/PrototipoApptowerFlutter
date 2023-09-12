import 'package:apptower/widgets/inputs/inputs_form.dart';
import 'package:apptower/widgets/inputs/inputs_formS.dart';
import 'package:flutter/material.dart';
import 'package:apptower/Models/Data.dart';

class ModalEditarUsuario extends StatefulWidget {
  const ModalEditarUsuario({
    Key? key,
    required this.usuario,
    required this.actualizarDatos,
  });
  final Map<String, dynamic> usuario;
  final Function actualizarDatos;

  @override
  State<ModalEditarUsuario> createState() => _ModalEditarUsuarioState();
}

class _ModalEditarUsuarioState extends State<ModalEditarUsuario> {
  final registro = ModulosData();

  late String SeleccionTD;
  late bool estado;
  late String dropdownValue;
  final TextEditingController _documento = TextEditingController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _apellido = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  List<String> roles = ['Administrador', 'Residente', 'Vigilante'];

  List<String> Td = ['CC', 'CE'];
  List<String> Est = ['Activo', 'Inactivo'];

  @override
  void initState() {
    super.initState();
    _actualizacion();
  }

  _actualizacion() {
    _nombre.text = widget.usuario['nombre'];
    _apellido.text = widget.usuario['apellido'];
    SeleccionTD = widget.usuario['tipo_documento'];
    _documento.text = widget.usuario['documento'].toString();
    _correo.text = widget.usuario['correo'];
    _telefono.text = widget.usuario['telefono'].toString();
    dropdownValue = widget.usuario['rol'];
    estado = widget.usuario['estado'];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Usuario'),
      content: SingleChildScrollView(
        child: Column(
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
              decoration: InputDecoration(
                labelText: 'Tipo de Documento',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
            ),
            InputsForm(
                controller: _documento,
                obscureText: false,
                hintext: 'Ingrese su Documento',
                labelText: 'Documento'),
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
            SizedBox(
              height: 7,
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
                if (newValue != null && roles.contains(newValue)) {
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
            SizedBox(height: 10),
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
              decoration: InputDecoration(
                labelText: 'Estado',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Guardar'),
          onPressed: () async {
            final Map<String, dynamic> nuevousuario = {
              "_id": widget.usuario['_id'],
              "tipo_documento": SeleccionTD,
              "documento": int.parse(_documento.text),
              "nombre": _nombre.text,
              "apellido": _apellido.text,
              "correo": _correo.text,
              "telefono": int.parse(_telefono.text),
              "rol": dropdownValue,
              "estado": estado == 'Activo',
            };

            try {
              await registro.actualizarRegistro(
                  nuevousuario, 'usuarios/usuarios/');
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Se actualizó el registro correctamente'),
                ),
              );
              widget.actualizarDatos();
            } catch (e) {
              print('Error al agregar usuario: $e');
            }
          },
        ),
      ],
    );
  }
}
