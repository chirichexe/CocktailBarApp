import 'package:flutter/material.dart';

class CreateIngredientModal extends StatelessWidget {
  final List<String> nomi;
  final List<double> quantita;
  final Function updateLists;

  CreateIngredientModal({
    Key? key,
    required this.nomi,
    required this.quantita,
    required this.updateLists,
  }) : super(key: key);

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerQuantita = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // Larghezza del dialogo al 30% della larghezza dello schermo
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controllerNome,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controllerQuantita,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ), // Accetta solo numeri e decimali
              decoration: InputDecoration(
                labelText: 'Quantità',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aggiungi il nome e la quantità alle liste
                String nome = controllerNome.text;
                double quantitaVal =
                    double.tryParse(controllerQuantita.text) ?? 0.0;

                nomi.add(nome);
                quantita.add(quantitaVal);

                // Chiudi il modal e aggiorna le liste nel CreateCocktailModal
                Navigator.of(context).pop();
                updateLists();

                // Pulisci i campi di testo
                controllerNome.clear();
                controllerQuantita.clear();
              },
              child: Text('Salva'),
            ),
          ],
        ),
      ),
    );
  }
}
