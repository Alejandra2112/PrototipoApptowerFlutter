import 'package:http/http.dart' as http; 
import 'dart:convert';

class ModulosData {
  final String baseUrl = 'https://backnodejs.onrender.com/api/';

  Future<Map<String, dynamic>> fetchData(String clave) async {
    final response = await http.get(Uri.parse('$baseUrl$clave'));
    print('$baseUrl$clave');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      
     
      throw Exception('Failed to load data');
    }
  }

  Future<void> agregarRegistro(Map<String, dynamic> nuevoRegistro, String clave) async {
    final response = await http.post(
      Uri.parse(baseUrl+clave),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(nuevoRegistro),
    );
    print(nuevoRegistro);
    if (response.statusCode == 200) {
    } else {
      print('Error: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
      throw Exception('Failed to add new visitor');
    }
  }

  Future<void> actualizarRegistro(Map<String, dynamic> actualizacion, String clave) async {
    final response = await http.put(
      Uri.parse(baseUrl+clave),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(actualizacion),
    );

    if (response.statusCode == 200) {
      print('Se actualizó el registro correctamente');
    } else {
      print('Error: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
      throw Exception('Failed to update visitor record');
    }
  }
  Future<void> eliminarRegistro(Map<String, dynamic> eliminacion, String clave) async {
    final response = await http.delete(
      Uri.parse(baseUrl+clave),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(eliminacion),
    );

    if (response.statusCode == 200) {
      print('Se actualizó el registro correctamente');
    } else {
      print('Error: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
      throw Exception('Failed to update visitor record');
    }
  }
}
