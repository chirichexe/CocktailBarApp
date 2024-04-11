// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

class createCocktailPage extends StatefulWidget {
  @override
  CocktailPage createState() => CocktailPage();
}

class CocktailPage extends State<createCocktailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktail'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Questa è la Pagina dei Cocktail!',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
