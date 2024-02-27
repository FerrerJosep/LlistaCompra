import 'package:appcompres2/providers/frutas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Muestra el contenido de frutasCompradas
          Text('Frutas Compradas:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
          Consumer<FrutasProvider>(
            builder: (context, frutasProvider, _) {
              // Obtiene el mapa de frutasCompradas del provider
              Map<String, int> frutasCompradas = frutasProvider.frutasCompradas;

              // Crea una lista de Widgets para mostrar cada fruta y la cantidad comprada
              List<Widget> frutasWidgets = frutasCompradas.entries.map((entry) {
                return Text('${entry.key}: ${entry.value}', style: TextStyle(fontSize: 32),);
              }).toList();

              // Muestra la lista de frutas y cantidades
              return Column(
                children: frutasWidgets,
              );
            },
          ),
        ],
      ),
    );
  }
}
