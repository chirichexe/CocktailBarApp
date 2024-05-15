import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/elements/ShouldDeleteDialog.dart';
import 'package:cocktailbarapp/pages/magazzino/elements/MagazzinoNavigator.dart';
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
            height: constraints.maxHeight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
                child: GFCard(
                  color: Colors.blueAccent,
                  elevation: 15, // Rimuove l'ombra di default di GFCard
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  titlePosition: GFPosition.start,
                  title: GFListTile(
                    avatar: const GFAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.warehouse,
                        color: Colors.blueAccent,
                        size: 30,
                      ),
                    ),
                    title: Text(
                      nome,
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subTitle: Text(
                      descrizione,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  content: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GFIconButton(
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
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
