import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _Drawer();
}

class _Drawer extends State<MyDrawer> {

  static String title='Scelta pagina'; //nome pagina Drawer
  int _selectedIndex = 0; //indice delle pagine
  static const TextStyle optionStyle =  //stile delle scritte nel Drawer
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[  //lista di elementi nel Drawer
    Text(
      'HomePage',
      style: optionStyle,
    ),
    Text(
      'SecondPage',
      style: optionStyle,
    ),
    Text(
      'ThirdPage',
      style: optionStyle,
    ),
    Text(
      'FourthPage',
      style: optionStyle,
    )
  ];

  void _onItemTapped(int index) { //gestione tocchi
    setState(() {
      _selectedIndex = index;
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Home Page')),
    body: Center(
      child: _widgetOptions[_selectedIndex],
    ),
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Scegli la pagina'),
          ),
          ListTile(
            title: const Text('HomePage'),
            selected: _selectedIndex == 0,
            onTap: () {
              // Update the state of the app
              _onItemTapped(0);
              // Then close the drawer
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text('SecondPage'),
            selected: _selectedIndex == 1,
            onTap: () {
              // Update the state of the app
              _onItemTapped(1);
              // Then close the drawer
              Navigator.pushNamed(context, '/second');
            },
          ),
          ListTile(
            title: const Text('ThirdPage'),
            selected: _selectedIndex == 2,
            onTap: () {
              // Update the state of the app
              _onItemTapped(2);
              // Then close the drawer
              Navigator.pushNamed(context, '/third');
            },
          ),
          ListTile(
            title: const Text('FourthPage'),
            selected: _selectedIndex == 3,
            onTap: () {
              // Update the state of the app
              _onItemTapped(3);
              // Then close the drawer
              Navigator.pushNamed(context, '/fourth');
            },
          ),
        ],
      ),
    ),
  );
}
}