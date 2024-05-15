// ignore: file_names
import 'package:cocktailbarapp/global/MainDrawer.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _Drawer();
}

class _Drawer extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home Page')),
        body: const Center(),
        drawer: const MainDrawer(
          initialIndex: 0,
          drawerTitle: "Cocktail App Bar",
          pageRoutes: {
            "/": "Home",
            "/magazzino": "Magazzino",
            "/cocktail": "Cocktail",
          },
        ));
  }
}
