import 'package:apptower/ScreenViews/camara.dart';
import 'package:apptower/ScreenViews/ubicacion.dart';
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
              "https://live.staticflickr.com/8230/8370563539_bb0cd406d5_b.jpg",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 120),
            color: Colors.black.withOpacity(0.5),
            child: const Text(
              "Nuestra comunidad residencial te brinda un espacio único que promueve la interacción y la conexión con tus vecinos, adaptado a tu estilo de vida y valores.",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 45, ),
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(255, 0, 9, 59),
                backgroundImage: NetworkImage(
                 "https://i.ibb.co/KL47c1Y/Logo-Apptower.png",
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
              leading: Icon(Icons.person, color: Colors.black,),
              title: Text('Usuarios',
              style: TextStyle(
            fontWeight: FontWeight.bold, 
          ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Usuarios()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.black,),
              title: Text('Roles',
              style: TextStyle(
            fontWeight: FontWeight.bold, 
          ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Roles()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.security_sharp, color: Colors.black,),
              title: Text('Vigilantes',
              style: TextStyle(
            fontWeight: FontWeight.bold,
          ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Vigilantes()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_enhance, color: Colors.black,),
              title: Text('Cámara',
              style: TextStyle(
            fontWeight: FontWeight.bold,
          ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Camera()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add_location, color: Colors.black,),
              title: Text('Ubicación',
              style: TextStyle(
            fontWeight: FontWeight.bold,
          ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MapaUbicacionView()),
                );
              },
            ),
            
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.black,),
                title: Text('Cerrar Sesión', style: TextStyle(
            fontWeight: FontWeight.bold, 
          ),),
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
