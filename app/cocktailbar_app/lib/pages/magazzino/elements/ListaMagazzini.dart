import 'package:flutter/material.dart';
import 'magazzino.dart';

class ListaMagazzini extends StatefulWidget {
  final List<Magazzino> elencoMagazzini;
  const ListaMagazzini({super.key, required this.elencoMagazzini});

  @override
  State<ListaMagazzini> createState() => _ListaMagazziniState();
}

class _ListaMagazziniState extends State<ListaMagazzini> {
  List<Magazzino> elencoMagazzini = [];

  @override
  void initState() {
    super.initState();
    elencoMagazzini = widget.elencoMagazzini;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 3, // Numero di colonne
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          padding: const EdgeInsets.all(10.0),
          children: List.generate(elencoMagazzini.length, (index) {
            return elencoMagazzini[index];
          })),
    );
  }
}
