import 'package:flutter/material.dart';


class FruitDetailsPage extends StatelessWidget {
  final String fruitName;
  final String fruitImage;
  final String fruitDescription;

  const FruitDetailsPage({
    Key? key,
    required this.fruitName,
    required this.fruitImage,
    required this.fruitDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Fruta: $fruitName'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              fruitImage,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              fruitName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              fruitDescription,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}