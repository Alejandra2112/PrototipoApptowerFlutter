import 'dart:convert';

import 'package:apptower/ScreenViews/registarU.dart';
import 'package:flutter/material.dart';
import 'package:apptower/ScreenViews/inicio.dart';
import 'package:apptower/themes/theme.dart';
import 'package:apptower/Models/Data.dart';
import 'package:http/http.dart' as http;

final List<String> estados = ["ACTIVO", "INACTIVO"];

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LoginState();
}

class _LoginState extends State<LogIn> {
  TextEditingController usuario = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  ModulosData modulosData = ModulosData();

  Future<void> _verificarUsuario() async {
    final response = await modulosData.fetchData('usuarios/usuarios');

    if (response.containsKey('usuario')) {
      final usuarios = response['usuario'] as List<dynamic>;
      var usuarioEncontrado;

      for (var usuarioData in usuarios) {
        final documento = usuarioData['documento'].toString();
        final correo = usuarioData['correo'].toString();

        if ((documento == usuario.text || correo == usuario.text) &&
            usuarioData['password'] == contrasena.text) {
          usuarioEncontrado = usuarioData;
          break;
        }
      }

      if (usuarioEncontrado != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Inicio()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Credenciales incorrectas"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al verificar el usuario"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(248, 249, 250, 1),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
                height: 300,
                child: Image.network(
                  "../img/Logo-Apptower.png",
                )),
            Padding(
              padding: AppTheme.selectPading,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: usuario,
                        obscureText: false,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Usuario',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: contrasena,
                        obscureText: true,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: AppTheme.selectPading,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppTheme.ApptowerBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        elevation: 4.0,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () async {
                        if (usuario.text.isEmpty || contrasena.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Usuario o Contraseña vacíos"),
                            ),
                          );
                        } else {
                          _verificarUsuario();
                        }
                      },
                      child: const Text("Ingresar"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistarU(),
                        ),
                      );
                    },
                    child: const Text(
                      "Registrarse",
                      style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 13, 13, 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
