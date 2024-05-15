import 'package:flutter/material.dart';
import 'Magazzino.dart';
class ListaMagazzini extends StatefulWidget {
  final List<Magazzino> elencoMagazzini;
  const ListaMagazzini({Key? key, required this.elencoMagazzini}) : super(key: key);

  @override
  State<ListaMagazzini> createState() => _ListaMagazziniState();
}

class _ListaMagazziniState extends State<ListaMagazzini> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: widget.elencoMagazzini.length,
          itemBuilder: (context, index) {
            return AspectRatio(
              aspectRatio: 1, // Mantieni un rapporto di aspetto quadrato
              child: widget.elencoMagazzini[index],
            );
          },
        ),
      ),
    );
  }
}
