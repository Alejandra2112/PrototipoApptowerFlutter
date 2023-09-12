import 'package:apptower/widgets/Roles/CartasRoles.dart';
import 'package:flutter/material.dart';
import 'package:apptower/Models/Data.dart';

class Roles extends StatefulWidget {
  const Roles({Key? key}) : super(key: key);

  @override
  _RolesState createState() => _RolesState();
}

class _RolesState extends State<Roles> {
  late Future<List<Map<String, dynamic>>> futureData;
  @override
  void initState() {
    super.initState();
    futureData = _cargarDatos();
  }

  Future<List<Map<String, dynamic>>> _cargarDatos() async {
    final datos = await ModulosData().fetchData('roles/roles/');
    return List<Map<String, dynamic>>.from(datos['roles']);
  }

  void actualizarDatos() {
    setState(() {
      futureData = _cargarDatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Roles')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<Map<String, dynamic>> roles =
                snapshot.data as List<Map<String, dynamic>>;
            return CartasRoles(
                informacion: roles, actualizarDatos: actualizarDatos);
          }
        },
      ),
      
    );
  }
}
