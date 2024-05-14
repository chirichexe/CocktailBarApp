import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class DeleteCocktailElementButton extends StatefulWidget {
  final String idElemento;
  const DeleteCocktailElementButton({super.key, required this.idElemento});

  @override
  State<DeleteCocktailElementButton> createState() =>
      _DeleteCocktailElementButtonState();
}

class _DeleteCocktailElementButtonState
    extends State<DeleteCocktailElementButton> {
  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: () async {
        try {
          // Esegui una query per trovare il documento che corrisponde alle condizioni specificate
          await FirebaseFirestore.instance
              .collection('Cocktails')
              .doc(widget.idElemento)
              .delete();

          // Se esiste un documento che corrisponde alle condizioni, elimina il documento
        } catch (error) {
          print('Errore durante l\'eliminazione dell\'elemento: $error');
        }
        Navigator.of(context).pop();
      },
      color: Colors.purple,
      text: 'Cancella Elemento',
      textColor: Colors.white,
    );
  }
}
