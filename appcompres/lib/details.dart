import 'package:flutter/material.dart';

class PurchaseController {
  Map<String, int> _fruitsPurchased = {};

  Map<String, int> get fruitsPurchased => _fruitsPurchased;

  void updateFruitsPurchased(String fruitName, int quantity) {
    if (_fruitsPurchased.containsKey(fruitName)) {
      _fruitsPurchased[fruitName] = _fruitsPurchased[fruitName]! + quantity;
    } else {
      _fruitsPurchased[fruitName] = quantity;
    }
  }
}

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> fruitData;
  final PurchaseController purchaseController;

  DetailPage({required this.fruitData, required this.purchaseController});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _showSnackbar() {
    final fruitName = widget.fruitData['fruit_name'];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '¡Has comprado $fruitName! Cantidad: $_counter',
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
    widget.purchaseController.updateFruitsPurchased(fruitName, _counter);
    _resetCounter();
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Fruit Name: ${widget.fruitData['fruit_name']}'),
            Text('Size: ${widget.fruitData['size']}'),
            Text('Color: ${widget.fruitData['color']}'),
            Text('Producer: ${widget.fruitData['major_producer']}'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: Icon(Icons.remove),
                ),
                SizedBox(width: 10),
                Text('$_counter'),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showSnackbar,
              child: Text('Comprar'),
            ),
            SizedBox(height: 20),
            Text('Total de frutas compradas:'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.purchaseController.fruitsPurchased.entries
                  .map((entry) {
                return Text('${entry.key}: ${entry.value}');
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
