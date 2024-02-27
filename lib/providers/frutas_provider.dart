import 'package:flutter/material.dart';

class FrutasProvider extends ChangeNotifier {
  Map<String, int> _frutasCompradas = {};

  Map<String, int> get frutasCompradas => _frutasCompradas;

  void incrementarContador(String fruta) {
    if (_frutasCompradas.containsKey(fruta)) {
      _frutasCompradas[fruta] = _frutasCompradas[fruta]! + 1;
    } else {
      _frutasCompradas[fruta] = 1;
    }
    notifyListeners();
  }

  void comprarFruta(String fruta) {
    incrementarContador(fruta);
  }

  void eliminarCompra(String fruta) {
    if (_frutasCompradas.containsKey(fruta)) {
      _frutasCompradas.remove(fruta);
      notifyListeners();
    }
  }
}
