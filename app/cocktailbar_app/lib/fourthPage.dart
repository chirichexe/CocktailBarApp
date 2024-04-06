// ignore_for_file: use_key_in_widget_constructors
import 'package:cocktailbar_app/checkableElement.dart';
import 'package:flutter/material.dart';

class createFourthPage extends StatefulWidget {
  @override
  FourthPage createState() => FourthPage();
}

class FourthPage extends State<createFourthPage> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Michele che frocetto che sei'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Il tuo bottone è ${_isChecked ? 'premuto' : 'non premuto'}',
              style: TextStyle(fontSize: _isChecked ? 50 : 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Torna alla Home Page'),
            ),
            const SizedBox(
              height: 20,
            ),
            CheckableElement(
              initialValue: false,
              elementName: 'Gin',
              onChanged: (value) {
                //Qui dovremo gestire l'accumulo
              },
            ),
            CheckableElement(
              initialValue: false,
              elementName: 'Arancia',
              onChanged: (value) {
                //Qui dovremo gestire l'accumulo
              },
            ),
            CheckableElement(
              initialValue: false,
              elementName: 'Spermatozoi',
              onChanged: (value) {
                //Qui dovremo gestire l'accumulo
              },
            )
          ],
        ),
      ),
    );
  }
}
