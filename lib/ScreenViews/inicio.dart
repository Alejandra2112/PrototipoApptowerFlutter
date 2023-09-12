import 'package:flutter/material.dart';
import 'package:apptower/ScreenViews/login.dart';
import 'package:apptower/ScreenViews/roles.dart';
import 'package:apptower/ScreenViews/usuarios.dart';
import 'package:apptower/ScreenViews/vigilantes.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            '../img/conjunto.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 120),
            color: Colors.black.withOpacity(0.5),
            child: const Text(
              "Nuestra comunidad residencial te brinda un espacio único que promueve la interacción y la conexión con tus vecinos, adaptado a tu estilo de vida y valores.",
              style: TextStyle(fontSize: 19.0, color: Colors.white),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(255, 0, 9, 59),
                backgroundImage: NetworkImage(
                  "../img/Logo-Apptower.png",
                ),
              ),
            ),
            SizedBox(height: 10),
            const Text(
              'APPTOWER',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 9, 59),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Usuarios'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Usuarios()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Roles'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Roles()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.security_sharp),
              title: Text('Vigilantes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Vigilantes()),
                );
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Cerrar Sesión'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogIn()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
