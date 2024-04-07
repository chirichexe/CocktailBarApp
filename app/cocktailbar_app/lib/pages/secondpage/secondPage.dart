// ignore_for_file: use_key_in_widget_constructors
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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Questa è la Seconda Pagina!',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
