import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';
import 'details.dart'; // Importa la clase DetailPage del archivo details.dart

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'My App',
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/tabNavigator': (context) => TabNavigator(),
    },
  ));
}

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    OtherPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme:
            IconThemeData(size: 30.0, color: Colors.black, opacity: 10.0),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.more_vert),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Icon(Icons.logout_rounded),
              )),
        ],
        backgroundColor: Colors.grey.shade500,
        leading: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('llistaCompra'),
                  content: const Text('Josep Ferrer'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(
            Icons.help_outline_rounded,
          ),
        ),
        title: const Text(
          'Login',
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> fruits = [];
  PurchaseController purchaseController = PurchaseController(); // Instancia del controlador de compras

  @override
  void initState() {
    super.initState();
    fetchFruits();
  }

  Future<void> fetchFruits() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/frutes/'));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      List<dynamic> fruitList = responseData['data'];
      setState(() {
        fruits = fruitList.cast<String>();
      });
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
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:  4, // Cambiar el número de columnas aquí según lo necesites
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: fruits.length,
      itemBuilder: (context, index) {
        return FruitButton(
          fruitName: fruits[index],
          purchaseController: purchaseController, // Pasa el controlador de compras a FruitButton
        );
      },
    );
  }
}

class FruitButton extends StatelessWidget {
  final String fruitName;
  final PurchaseController purchaseController; // Añade el controlador de compras como argumento

  FruitButton({required this.fruitName, required this.purchaseController}); // Actualiza el constructor

  @override
  Widget build(BuildContext context) {
    String imageName = fruitName.toLowerCase().replaceAll(' ', '_');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: () async {
          final response = await http.get(
            Uri.parse('http://localhost:8080/api/frutes/$fruitName'),
          );
          if (response.statusCode == 200) {
            Map<String, dynamic> responseData = json.decode(response.body);
            Map<String, dynamic> fruitData = responseData['data'];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  fruitData: fruitData,
                  purchaseController: purchaseController, // Pasa el controlador de compras a DetailPage
                ),
              ),
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
        icon: Image.asset(
          'assets/$imageName.png',
          width: 100,
          height: 100,
        ),
        label: const Text(""),
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Other Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
