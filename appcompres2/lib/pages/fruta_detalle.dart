import 'package:appcompres2/providers/frutas_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class FrutaDetallePage extends StatefulWidget {
  final String fruta;

  FrutaDetallePage({required this.fruta});

  @override
  _FrutaDetallePageState createState() => _FrutaDetallePageState();
}

class _FrutaDetallePageState extends State<FrutaDetallePage> {
  Map<String, dynamic>? _datosFruta;

  @override
  void initState() {
    super.initState();
    _cargarDatosFruta();
  }

  Future<void> _cargarDatosFruta() async {
    try {
      var response = await http
          .get(Uri.parse('http://localhost:8080/api/frutes/${widget.fruta}'));

      if (response.statusCode == 200) {
        setState(() {
          _datosFruta = json.decode(response.body)['data'];
        });
      } else {
        print('Error al cargar los datos de la fruta: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al cargar los datos de la fruta: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Fruta'),
        backgroundColor: Colors.blueGrey.shade100,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_datosFruta != null) ...[
              Text('Detalles de la fruta: ${widget.fruta}'),
              SizedBox(height: 20),
              Text('Tamaño: ${_datosFruta!['size']}'),
              Text('Color: ${_datosFruta!['color']}'),
              Text('Productor Principal: ${_datosFruta!['major_producer']}'),
            ] else ...[
              CircularProgressIndicator(),
            ],

           
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Provider.of<FrutasProvider>(context, listen: false)
                    .comprarFruta(widget.fruta);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Compra realizada'),
                      content: Text('Has comprado 1 ${widget.fruta}'),
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
              },
              child: Text('Comprar'),
            ),
            SizedBox(height: 50),
             Consumer<FrutasProvider>(
              builder: (context, frutasProvider, _) {
                int contador =
                    frutasProvider.frutasCompradas[widget.fruta] ?? 0;
                return Column(
                  children: [
                    Text('Unidades compradas: $contador'),
                    SizedBox(height:20),
                    ElevatedButton(
                      onPressed: () {
                        frutasProvider.eliminarCompra(widget.fruta);
                        
                      },
                      child: Text('Eliminar compra'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
