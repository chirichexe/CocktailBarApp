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

  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerQuantita = TextEditingController();

  void onPressedButton() {}

  @override
  Widget build(BuildContext context) {
    double modalWidth = MediaQuery.of(context).size.width * 0.3;
    double modalHeight = MediaQuery.of(context).size.height * 0.4;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: modalWidth,
        height: modalHeight,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextField(
                controller: controllerNome,
                decoration: InputDecoration(
                  labelText: 'Nome Ingrediente',
                  labelStyle: const TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: TextField(
                controller: controllerQuantita,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Quantità (in ml)',
                  labelStyle: const TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                if (controllerNome.text.isNotEmpty) {
                  String nome = controllerNome.text;
                  double quantitaVal = double.tryParse(controllerQuantita.text) ?? 0.0;

                  ingredients.add(Ingredient(name: nome, qty: quantitaVal));

                  // Chiudi il modal e aggiorna le liste nel CreateCocktailModal
                  Navigator.of(context).pop();
                  updateLists();

                  // Pulisci i campi di testo
                  controllerNome.clear();
                  controllerQuantita.clear();
                }
              },
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              elevation: 4,
              child: const Text(
                'Salva',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
