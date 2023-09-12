import 'package:apptower/ScreenViews/vigilantes.dart';
import 'package:apptower/widgets/inputs/inputs_form.dart';
import 'package:apptower/widgets/inputs/inputs_formS.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:apptower/Models/Data.dart';

class RegistrarVigilanteVista extends StatefulWidget {
  RegistrarVigilanteVista({
    super.key,
  });

  @override
  State<RegistrarVigilanteVista> createState() =>
      _RegistrarVigilanteVistaState();
}

class _RegistrarVigilanteVistaState extends State<RegistrarVigilanteVista> {
  final registro = ModulosData();

  late String SeleccionTD = "CC";
  late bool estado = true;

  final TextEditingController _documento = TextEditingController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _apellido = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _fechaNacimiento = TextEditingController();

  List<String> Td = ['CC', 'CE'];
  List<String> Est = ['Activo', 'Inactivo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Vigilante"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: SingleChildScrollView(
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
                height: 8,
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
                  final Map<String, dynamic> nuevoVigilante = {
                    "tipo_documento": SeleccionTD,
                    "documento": int.parse(_documento.text),
                    "nombre": _nombre.text,
                    "apellido": _apellido.text,
                    "correo": _correo.text,
                    "telefono": int.parse(_telefono.text),
                    "fechaNacimiento": _fechaNacimiento.text,
                    "estado": estado == 'Activo',
                  };
                  try {
                    await registro.agregarRegistro(
                        nuevoVigilante, 'vigilantes/vigilantes/');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Se agregó el registro correctamente'),
                      ),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vigilantes()),
                    );
                  } catch (e) {
                    print('Error al agregar  $e');
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
