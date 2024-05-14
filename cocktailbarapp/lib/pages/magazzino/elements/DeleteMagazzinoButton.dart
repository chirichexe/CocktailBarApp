import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/elements/ShouldDeleteDialog.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class DeleteMagazzinoButton extends StatefulWidget {
  final String idElemento;
  const DeleteMagazzinoButton({Key? key, required this.idElemento})
      : super(key: key);

  @override
  State<DeleteMagazzinoButton> createState() =>
      _DeleteCocktailElementButtonState();
}

class _DeleteCocktailElementButtonState extends State<DeleteMagazzinoButton> {
  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: () async {
        bool shouldDelete = await ShouldDeleteDialog.showDeleteDialog(context);
        if (shouldDelete) {
          try {
            // Esegui una query per trovare il documento che corrisponde alle condizioni specificate
            await FirebaseFirestore.instance
                .collection('Magazzini')
                .doc(widget.idElemento)
                .delete();

            // Se esiste un documento che corrisponde alle condizioni, elimina il documento
          } catch (error) {
            print('Errore durante l\'eliminazione dell\'elemento: $error');
          }
        }
      },
      color: Colors.purple,
      text: 'Cancella Magazzino',
      textColor: Colors.white,
    );
  }
}
