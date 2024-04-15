// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

class CocktailPage extends StatefulWidget {
  @override
  State<CocktailPage> createState() => _CocktailState();
}

class _CocktailState extends State<CocktailPage> {
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
