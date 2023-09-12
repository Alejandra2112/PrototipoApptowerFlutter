import 'package:apptower/widgets/inputs/inputs_form.dart';
import 'package:apptower/widgets/inputs/inputs_formS.dart';
import 'package:flutter/material.dart';
import 'package:apptower/Models/Data.dart';
import 'package:intl/intl.dart';

class ModalEditarVigilante extends StatefulWidget {
  const ModalEditarVigilante({
    Key? key,
    required this.vigilante,
    required this.actualizarDatos,
  }) : super(key: key);

  final Map<String, dynamic> vigilante;
  final Function actualizarDatos;

  @override
  State<ModalEditarVigilante> createState() => _ModalEditarVigilanteState();
}

class _ModalEditarVigilanteState extends State<ModalEditarVigilante> {
  final registro = ModulosData();
  late String SeleccionTD;
  late bool estado;

  final TextEditingController _documento = TextEditingController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _apellido = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _fechaNacimiento = TextEditingController();

  List<String> Td = ['CC', 'CE'];
  List<String> Est = ['Activo', 'Inactivo'];

  @override
  void initState() {
    super.initState();
    _actualizacion();
  }

  _actualizacion() {
    _nombre.text = widget.vigilante['nombre'];
    _apellido.text = widget.vigilante['apellido'];
    SeleccionTD = widget.vigilante['tipo_documento'];
    _documento.text = widget.vigilante['documento'].toString();
    _correo.text = widget.vigilante['correo'];
    _telefono.text = widget.vigilante['telefono'].toString();
    _fechaNacimiento.text = widget.vigilante['fechaNacimiento'];
    estado = widget.vigilante['estado'];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar vigilante'),
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
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
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
            TextFormField(
              controller: _fechaNacimiento,
              readOnly: true,
              onTap: () async {
                DateTime selectedDate = DateTime.now();
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != selectedDate) {
                  setState(() {
                    selectedDate = picked;
                    _fechaNacimiento.text =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Fecha de Nacimiento',
                hintText: 'Seleccionar Fecha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
            final Map<String, dynamic> nuevovigilante = {
              "_id": widget.vigilante['_id'],
              "tipo_documento": SeleccionTD,
              "documento": int.parse(_documento.text),
              "nombre": _nombre.text,
              "apellido": _apellido.text,
              "correo": _correo.text,
              "telefono": int.parse(_telefono.text),
              "fechaNacimiento": _fechaNacimiento.text,
              "estado": estado == 'Activo', // Convierte a booleano
            };

            try {
              await registro.actualizarRegistro(
                  nuevovigilante, 'vigilantes/vigilantes/');
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Se actualizó el registro correctamente'),
                ),
              );
              widget.actualizarDatos();
            } catch (e) {
              print('Error al agregar vigilante: $e');
            }
          },
        ),
      ],
    );
  }
}
