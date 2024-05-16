import 'package:cocktailbarapp/pages/magazzino/navigator/elements/MagazzinoElementModal.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MagazzinoElement extends StatelessWidget {
  final String nome;
  final String descrizione;
  final String idMagazzino;
  final String idElemento;

  const MagazzinoElement({
    super.key,
    required this.nome,
    required this.descrizione,
    required this.idMagazzino,
    required this.idElemento,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Funzione per aprire il modale
        _showModal(context);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.blue[600],
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                nome,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30, // Dimensione del testo aumentata
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Icon(
                Icons.local_drink,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MagazzinoElementModal(
            nome: nome,
            descrizione: descrizione,
            idEl: idElemento,
            idMag: idMagazzino,
          );
        });
  }
}
