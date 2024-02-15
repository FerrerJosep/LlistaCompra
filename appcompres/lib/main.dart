import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';

void main() {
  runApp(MaterialApp(
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
        title: Text('Catalogo: '),
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
    return Center(
      child: ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          return FruitButton(
            fruitName: fruits[index],
          );
        },
      ),
    );
  }
}

class FruitButton extends StatelessWidget {
  final String fruitName;

  FruitButton({required this.fruitName});

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
                builder: (context) => DetailPage(fruitData: fruitData),
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
          width: 50,
          height: 50,
        ),
        label: Text(fruitName),
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
            Text('Producer: ${fruitData['major_producer']}'),
          ],
        ),
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
