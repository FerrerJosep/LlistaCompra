import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalogo: '),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              final response = await http
                  .get(Uri.parse('http://localhost:8080/api/frutes/Apple'));
              if (response.statusCode == 200) {
                Map<String, dynamic> responseData = json.decode(response.body);
                Map<String, dynamic> fruitData = responseData['data'];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(fruitData: fruitData)),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('Failed to load fruit data.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Image.asset(
              "assets/apple.png",
              width: 150,
              height: 150,
            )),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> fruitData;

  DetailPage({required this.fruitData});

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
            Text('Fruit Name: ${fruitData['fruit_name']}'),
            Text('Size: ${fruitData['size']}'),
            Text('Color: ${fruitData['color']}'),
          ],
        ),
      ),
    );
  }
}
