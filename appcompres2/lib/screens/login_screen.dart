import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appcompres2/screens/home_screen.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();

  Future<void> _login() async {
    final String username = _userController.text;
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/clients'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<String> registeredUsers = List<String>.from(data['data']);

      if (registeredUsers.contains(username)) {
        // Usuario registrado, navega a la pantalla HomeScreen
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        // Usuario no registrado, muestra un mensaje de error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error de autenticación'),
              content: Text('El usuario ingresado no está registrado.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cerrar'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Error al obtener la lista de usuarios registrados
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error de conexión'),
            content: Text('No se pudo conectar al servidor.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              // Añadido para centrar horizontalmente
              child: Container(
                color: Colors.white,
                width: 300, // Ajusta esto a la medida que prefieras
                child: TextField(
                  controller: _userController,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login, // Llama al método _login al presionar el botón
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
