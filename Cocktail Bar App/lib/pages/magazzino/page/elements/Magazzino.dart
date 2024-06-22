import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/elements/ShouldDeleteDialogCocktails.dart';
import 'package:cocktailbarapp/pages/magazzino/navigator/MagazzinoNavigator.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class Magazzino extends StatelessWidget {
  final String nome;
  final String descrizione;
  final String id;

  const Magazzino({
    Key? key,
    required this.id,
    required this.descrizione,
    required this.nome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: constraints.maxWidth * 0.9, // Larghezza massima del widget
            height: constraints.maxWidth * 0.9, // Altezza massima del widget
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MagazzinoNavigator(
                        id: id,
                        nome: nome,
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.warehouse,
                        color: Colors.blueAccent,
                        size: constraints.maxWidth *
                            0.15, // Dimensione dell'icona adattata alla larghezza dello schermo
                      ),
                      radius: constraints.maxWidth *
                          0.1, // Dimensione del raggio del cerchio adattata alla larghezza dello schermo
                    ),
                    SizedBox(
                        height: constraints.maxWidth *
                            0.05), // Spazio tra l'icona e il testo
                    Text(
                      nome,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: constraints.maxWidth *
                            0.07, // Dimensione del testo adattata alla larghezza dello schermo
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      descrizione,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: constraints.maxWidth *
                            0.06, // Dimensione del testo adattata alla larghezza dello schermo
                        fontWeight: FontWeight.normal,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(
                        height: constraints.maxWidth *
                            0.05), // Spazio tra il testo e il pulsante
                    GFIconButton(
                      onPressed: () async {
                        await ShouldDeleteDialog.showDeleteDialog(
                          context,
                          FirebaseFirestore.instance
                              .collection('Magazzini')
                              .doc(id),
                        );
                      },
                      icon: Icon(Icons.delete),
                      shape: GFIconButtonShape.circle,
                      color: Colors.redAccent,
                      iconSize: constraints.maxWidth *
                          0.08, // Dimensione dell'icona del pulsante adattata alla larghezza dello schermo
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
