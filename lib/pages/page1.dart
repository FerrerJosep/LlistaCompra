import 'dart:convert'; // Importa el paquete convert para trabajar con JSON
import 'package:appcompres2/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'fruta_detalle.dart';
import 'package:provider/provider.dart'; // Importa la pantalla de detalles de la fruta

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<String> fruits = []; // Lista para almacenar los nombres de las frutas

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/frutes/'));
    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, procesa la respuesta JSON
      final jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        // Si el estado es 'ok', obtén los datos de las frutas
        final List<dynamic> fruitData = jsonData['data'];
        setState(() {
          fruits = fruitData.cast<String>().toList();
        });
      } else {
        // Si hay un error en el estado, muestra un mensaje de error
        print('Error en el estado: ${jsonData['status']}');
      }
    } else {
      // Si la solicitud no fue exitosa, muestra un mensaje de error
      print('Error en la solicitud: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(context.watch<CounterProvider>().counter.toString()),
          ElevatedButton(
            onPressed: () {
              context.read<CounterProvider>().increment();
            },
            child: Text("Sumar"),
          ),
          SizedBox(height: 20),
          Text('Frutas disponibles:', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: fruits.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // Navegar a la pantalla de detalles de la fruta cuando se hace clic en la fruta
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FrutaDetallePage(fruta: fruits[index]),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(fruits[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                    // Puedes agregar más personalización aquí si es necesario
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
