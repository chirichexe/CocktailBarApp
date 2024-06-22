import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/elements/ShouldDeleteDialogCocktails.dart';
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
        await ShouldDeleteDialog.showDeleteDialog(
          context,
          FirebaseFirestore.instance
              .collection('Cocktails')
              .doc(widget.idElemento),
        );
      },
      color: Colors.purple,
      text: 'Cancella Elemento',
      textColor: Colors.white,
    );
  }
}
