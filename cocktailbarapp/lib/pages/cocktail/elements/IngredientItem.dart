import 'package:cocktailbarapp/pages/cocktail/classes/Ingredient.dart';
import 'package:flutter/material.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientItem({Key? key, required this.ingredient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5), // Padding ridotto
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10), // Border radius ridotto
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            ingredient.name,
            style: TextStyle(
              fontSize: 14, // Font size ridotto
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2), // Spaziatura ridotta
          Text(
            '${ingredient.qty.toStringAsFixed(2)} ml',
            style: TextStyle(
              fontSize: 10, // Font size ridotto
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 2), // Spaziatura ridotta
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Add delete functionality here
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}