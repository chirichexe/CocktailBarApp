// ignore_for_file: use_key_in_widget_constructors
import 'package:cocktailbar_app/pages/fourthpage/elements/checkable_element.dart';
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
        title: const Text('Seleziona gli ingredienti'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Scegli gli elementi',
              style: TextStyle(fontSize: _isChecked ? 50 : 20),
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
              elementName: 'Test1',
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
