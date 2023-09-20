import 'package:apptower/ScreenViews/registrarU.dart';
import 'package:apptower/widgets/usuarios/RegistrarUsuarioVista.dart';
import 'package:flutter/material.dart';
import 'package:apptower/Models/Data.dart';
import 'package:apptower/widgets/usuarios/CartasUsuarios.dart';

class Usuarios extends StatefulWidget {
  const Usuarios({Key? key}) : super(key: key);

  @override
  _UsuariosState createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
  late Future<List<Map<String, dynamic>>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = _cargarDatos();
  }

  Future<List<Map<String, dynamic>>> _cargarDatos() async {
    final datos = await ModulosData().fetchData('usuarios/usuarios/');
    return List<Map<String, dynamic>>.from(datos['usuario']);
  }

  void actualizarDatos() {
    setState(() {
      futureData = _cargarDatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios')),
      
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
            final List<Map<String, dynamic>> usuario =
                snapshot.data as List<Map<String, dynamic>>;
            return CartasUsuarios(
                informacion: usuario, actualizarDatos: actualizarDatos);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 26, 78, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrarUsuarioVista()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
