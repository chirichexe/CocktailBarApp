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
        return ShouldDeleteDialog(
            documentReference: FirebaseFirestore.instance
                .collection('Magazzini')
                .doc(idElemento));
      },
      color: Colors.purple,
      text: 'Cancella Magazzino',
      textColor: Colors.white,
    );
  }
}
