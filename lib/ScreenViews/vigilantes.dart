import 'package:apptower/widgets/Vigilantes/CartasVigilantes.dart';
import 'package:apptower/widgets/Vigilantes/RegistrarVigilanteVista.dart';
import 'package:apptower/widgets/usuarios/RegistrarUsuarioVista.dart';
import 'package:flutter/material.dart';
import 'package:apptower/Models/Data.dart';

class Vigilantes extends StatefulWidget {
  const Vigilantes({Key? key}) : super(key: key);

  @override
  _VigilantesState createState() => _VigilantesState();
}

class _VigilantesState extends State<Vigilantes> {
  late Future<List<Map<String, dynamic>>> futureData;
  @override
  void initState() {
    super.initState();
    futureData = _cargarDatos();
  }

  Future<List<Map<String, dynamic>>> _cargarDatos() async {
    final datos = await ModulosData().fetchData('vigilantes/vigilantes/');
    return List<Map<String, dynamic>>.from(datos['vigilantes']);
  }

  void actualizarDatos() {
    setState(() {
      futureData = _cargarDatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vigilantes')),
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
            return CartasVigilantes(
                informacion: roles, actualizarDatos: actualizarDatos);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 26, 78, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrarVigilanteVista()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
