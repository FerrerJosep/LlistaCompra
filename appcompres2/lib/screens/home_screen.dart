import 'package:flutter/material.dart';
import 'package:appcompres2/pages/page1.dart';
import 'package:appcompres2/pages/page2.dart';
import 'package:appcompres2/screens/login_screen.dart'; // Importa la pantalla de inicio de sesión

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[const Page1(), const Page2()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navega a la pantalla de inicio de sesión y reemplaza la pantalla actual
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.wallet_rounded), label: "Wallet")
        ],
      ),
    );
  }
}
