import 'package:flutter/material.dart';
import '../classes/Ingredient.dart';

class CreateIngredientModal extends StatelessWidget {
  final List<Ingredient> ingredients;
  final Function updateLists;

  CreateIngredientModal({
    Key? key,
    required this.ingredients,
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
              decoration: const InputDecoration(
                labelText: 'Nome Ingrediente',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controllerQuantita,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ), // Accetta solo numeri e decimali
              decoration: const InputDecoration(
                labelText: 'Quantità (in ml)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aggiungi il nome e la quantità alle liste
                String nome = controllerNome.text;
                double quantitaVal =
                    double.tryParse(controllerQuantita.text) ?? 0.0;

                ingredients.add(Ingredient(name: nome, qty: quantitaVal));

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