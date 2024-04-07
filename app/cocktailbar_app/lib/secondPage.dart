// ignore_for_file: use_key_in_widget_constructors
import 'package:cocktailbar_app/checkableElement.dart';
import 'package:flutter/material.dart';

class createSecondPage extends StatefulWidget {
  @override
  SecondPage createState() => SecondPage();
}

class SecondPage extends State<createSecondPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seconda Pagina'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Questa è la Seconda Pagina!',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

}