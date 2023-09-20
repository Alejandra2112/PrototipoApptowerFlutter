import 'package:flutter/material.dart';
import 'package:apptower/Models/Data.dart';
import 'package:intl/intl.dart';
import 'modalActualizaV.dart';

class CartasUsuarios extends StatefulWidget {
  const CartasUsuarios({
    Key? key,
    required this.informacion,
    required this.actualizarDatos,
  });

  final List<Map<String, dynamic>> informacion;
  final Function actualizarDatos;

  @override
  State<CartasUsuarios> createState() => _CartasUsuariosState();
}

class _CartasUsuariosState extends State<CartasUsuarios> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.informacion.length,
      itemBuilder: (context, index) {
        final usuario = widget.informacion[index];
        final fechaTexto = usuario['fecha'];
        final fecha = DateTime.parse(fechaTexto);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(
                '${usuario['nombre']} ${usuario['apellido']}',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tipo de documento: ${usuario['tipo_documento']}'),
                  Text('Documento: ${usuario['documento']}'),
                  Text('Correo: ${usuario['correo']}'),
                  Text('Teléfono: ${usuario['telefono']}'),
                  Text('Rol: ${usuario['rol']}'),
                  Text('Fecha: ${DateFormat('dd/MM/yyyy').format(fecha)}'),
                  Text('Estado: ${usuario['estado'] ? 'Activo' : 'Inactivo'}'),
                ],
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
                          return ModalEditarUsuario(
                            usuario: usuario,
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
                            title: const Text('Eliminar usuario'),
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
                                    '_id': usuario['_id']
                                  };
                                  await registro.eliminarRegistro(
                                      eliminacion, 'usuarios/usuarios/');
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
