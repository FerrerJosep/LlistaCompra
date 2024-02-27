import 'package:appcompres2/providers/frutas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrutaDetallePage extends StatelessWidget {
  final String fruta;

  FrutaDetallePage({required this.fruta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Fruta'),
      ),
      body: Center(
        child: Consumer<FrutasProvider>(
          builder: (context, frutasProvider, _) {
            int contador = frutasProvider.frutasCompradas[fruta] ?? 0;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Detalles de la fruta: $fruta'),
                SizedBox(height: 20),
                Text('Unidades: $contador'),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        frutasProvider.comprarFruta(fruta);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Compra realizada'),
                              content: Text('Has comprado 1 $fruta'),
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
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        frutasProvider.eliminarCompra(fruta);
                        // Puedes mostrar un diálogo o realizar otras acciones después de eliminar la compra
                      },
                      child: Text('Eliminar compra'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
