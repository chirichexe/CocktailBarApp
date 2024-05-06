import 'package:flutter/material.dart';

// Definizione della classe per gli ingredienti del cocktail
class Ingredient {
  String name;
  int quantity; // Quantità in ml

  Ingredient(this.name, this.quantity);
}

// Widget per visualizzare un singolo ingrediente
class IngredientWidget extends StatelessWidget {
  final Ingredient ingredient;
  final ValueChanged<int> onChanged;

  IngredientWidget({required this.ingredient, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ingredient.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${ingredient.quantity} ml'),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => onChanged(ingredient.quantity + 1),
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () => onChanged(ingredient.quantity - 1),
          ),
        ],
      ),
    );
  }
}

// Widget per la lista di ingredienti del cocktail
class CocktailIngredients extends StatefulWidget {
  @override
  _CocktailIngredientsState createState() => _CocktailIngredientsState();
}

class _CocktailIngredientsState extends State<CocktailIngredients> {
  List<Ingredient> ingredients = [];
  final TextEditingController nameController = TextEditingController();

  // Funzione per aggiungere un nuovo ingrediente
  void addIngredient(String name) {
    setState(() {
      ingredients.add(Ingredient(name, 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cocktail Ingredients'),
      ),
      body: ListView(
        children: [
          // Widget per aggiungere nuovi ingredienti
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter ingredient name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (nameController.text.isNotEmpty) {
                      addIngredient(nameController.text);
                      nameController.clear();
                    }
                  },
                ),
              ),
              controller: nameController,
            ),
          ),
          // Elenco degli ingredienti
          ...ingredients.map((ingredient) => IngredientWidget(
                ingredient: ingredient,
                onChanged: (newQuantity) {
                  setState(() {
                    ingredient.quantity = newQuantity;
                  });
                },
              )),
        ],
      ),
    );
  }
}
