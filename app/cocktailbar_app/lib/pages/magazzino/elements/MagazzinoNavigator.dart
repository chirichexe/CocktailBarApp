import 'package:cocktailbar_app/pages/magazzino/elements/MagazzinoElement.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MagazzinoNavigator extends StatefulWidget {
  int id;

  MagazzinoNavigator({super.key, required this.id});

  @override
  State<MagazzinoNavigator> createState() => _MagazzinoNavigatorState();
}

class _MagazzinoNavigatorState extends State<MagazzinoNavigator> {
  int _id = 0;

  @override
  void initState() {
    super.initState();

    _id = widget.id;
  }

  void onPressedButton() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Magazzino con id: " + _id.toString()),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                GFIconButton(
                  padding: EdgeInsets.all(15.0),
                  icon: Icon(Icons.plus_one),
                  onPressed: onPressedButton,
                  color: Colors.black,
                ),
                const Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              children: List.generate(
                growable: true,
                10, // Replace with your desired number of items
                (index) {
                  return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: MagazzinoElement(
                          idMagazzino: _id,
                          idElemento: 2, //Preso dal database
                          nome: "paoloCiaccia" //Preso dal database
                          ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
