// ignore_for_file: use_key_in_widget_constructors
import 'package:cocktailbar_app/checkableElement.dart';
import 'package:flutter/material.dart';

class createThirdPage extends StatefulWidget {
  @override
  ThirdPage createState() => ThirdPage();
}

class ThirdPage extends State<createThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terza Pagina'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Questa è la Terza Pagina!',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}