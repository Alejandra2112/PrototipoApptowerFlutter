import 'package:apptower/widgets/Vigilantes/modalActualizarV.dart';
import 'package:flutter/material.dart';
import 'package:apptower/Models/Data.dart';

class CartasVigilantes extends StatefulWidget {
  const CartasVigilantes({
    Key? key,
    required this.informacion,
    required this.actualizarDatos,
  });

  final List<Map<String, dynamic>> informacion;
  final Function actualizarDatos;

  @override
  State<CartasVigilantes> createState() => _CartasVigilantesState();
}

class _CartasVigilantesState extends State<CartasVigilantes> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.informacion.length,
      itemBuilder: (context, index) {
        final vigilantes = widget.informacion[index];

        DateTime fechaNacimiento =
            DateTime.parse(vigilantes['fechaNacimiento']);
        DateTime fechaActual = DateTime.now();
        int edad = fechaActual.year - fechaNacimiento.year;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: ListTile(
              leading: Icon(Icons.security),
              title: Text(
                '${vigilantes['nombre']} ${vigilantes['apellido']}',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Tipo de documento: ${vigilantes['tipo_documento']}\n'
                'Documento: ${vigilantes['documento']}\n'
                'Correo: ${vigilantes['correo']}\n'
                'Teléfono: ${vigilantes['telefono']}\n'
                'Edad: $edad años\n'
                'Estado: ${vigilantes['estado'] ? 'Activo' : 'Inactivo'}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ModalEditarVigilante(
                            vigilante: vigilantes,
                            actualizarDatos: widget.actualizarDatos,
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Eliminar vigilantes'),
                            content: const Text(
                                '¿Está seguro que desea eliminar este registro?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 5, 0, 34),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final registro = ModulosData();
                                  Map<String, dynamic> eliminacion = {
                                    '_id': vigilantes['_id']
                                  };
                                  await registro.eliminarRegistro(
                                      eliminacion, 'vigilantes/vigilantes/');
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Se eliminó el registro correctamente'),
                                    ),
                                  );
                                  widget.actualizarDatos();
                                },
                                child: const Text(
                                  'Eliminar',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 5, 0, 34),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
