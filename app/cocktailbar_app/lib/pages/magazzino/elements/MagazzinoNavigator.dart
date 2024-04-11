import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MagazzinoNavigator extends StatefulWidget {
  String elementName;
  int elementsNumber;

  MagazzinoNavigator(
      {super.key, required this.elementName, required this.elementsNumber});

  @override
  State<MagazzinoNavigator> createState() => _MagazzinoNavigatorState();
}

class _MagazzinoNavigatorState extends State<MagazzinoNavigator> {
  String _elementName = "";
  int _elementsNumber = 0;

  void initState() {
    super.initState();

    _elementName = widget.elementName;
    _elementsNumber = widget.elementsNumber;
  }

  void onPressedButton() {
    this._elementsNumber = this._elementsNumber + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_elementName),
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
                _elementsNumber, // Replace with your desired number of items
                (index) {
                  return const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GFCard(
                      color: Color.fromARGB(255, 26, 5, 146),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      title: GFListTile(
                        titleText: 'Questa è una cacca',
                        color: GFColors.WHITE,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
