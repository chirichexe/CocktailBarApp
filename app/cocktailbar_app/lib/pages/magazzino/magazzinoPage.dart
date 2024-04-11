// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';


class createMagazzinoPage extends StatefulWidget {
  @override
  MagazzinoPage createState() => MagazzinoPage();
}

class MagazzinoPage extends State<createMagazzinoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Magazzino'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Questa è la Pagina del Magazzino!',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
