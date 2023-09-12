import 'package:flutter/material.dart';
import 'package:apptower/Models/Data.dart';

class CartasRoles extends StatefulWidget {
  const CartasRoles({
    Key? key,
    required this.informacion,
    required this.actualizarDatos,
  });

  final List<Map<String, dynamic>> informacion;
  final Function actualizarDatos;

  @override
  State<CartasRoles> createState() => _CartasRolesState();
}

class _CartasRolesState extends State<CartasRoles> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.informacion.length,
      itemBuilder: (context, index) {
        final roles = widget.informacion[index];
        final permisos = (roles['permisos'] as List<dynamic>).join(', ');

        return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.settings), 
              title: Text('${roles['nombreRol']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Descripción: ${roles['descripcionRol']}'),
                  Text('Permisos: $permisos'),
                  Text('Estado: ${roles['estado'] ? 'Activo' : 'Inactivo'}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
