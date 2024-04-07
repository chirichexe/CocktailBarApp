import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  final int initialIndex;
  final String drawerTitle;
  final Map<String, String> pageRoutes;

  const MainDrawer(
      {super.key,
      required this.initialIndex,
      required this.drawerTitle,
      required this.pageRoutes});

  @override
  // ignore: library_private_types_in_public_api
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  int _selectedIndex = 0; //indice delle pagine
  String _drawerTitle = "";
  List<String> _pageRoutesTitles = [];
  List<String> _pageRoutes = [];

  static const TextStyle optionStyle = //stile delle scritte nel Drawer
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  void initState() {
    super.initState();
    //Inizializzo i primi due valori
    _selectedIndex = widget.initialIndex;
    _drawerTitle = widget.drawerTitle;

    //Separo chiavi e valori in due liste private separate
    _pageRoutes = widget.pageRoutes.keys.toList();
    _pageRoutesTitles = widget.pageRoutes.values.toList();
  }

  void _onItemTapped(int index) {
    //gestione tocchi
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(_drawerTitle),
          ),
          for (int i = 0; i < _pageRoutes.length; i++)
            ListTile(
              title: Text(
                _pageRoutesTitles[i],
                style: optionStyle,
              ),
              selected: _selectedIndex == i,
              onTap: () {
                _onItemTapped(i);
                // Effettua il routing alla pagina corrispondente quando l'utente tocca la ListTile
                Navigator.pushNamed(context, _pageRoutes[i]);
              },
            ),
        ],
      ),
    );
  }
}
