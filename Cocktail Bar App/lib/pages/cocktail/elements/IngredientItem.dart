import 'package:flutter/material.dart';
import 'package:cocktailbarapp/pages/cocktail/classes/Ingredient.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  final VoidCallback onDelete;

  const IngredientItem({Key? key, required this.ingredient, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String quantity = ingredient.qty;
    double doubleValue = 0.0;

    try {
      double doubleValue = double.parse(quantity);
      quantity = doubleValue.toString() + " ml";
    } catch (e){
      
    }

    return Container(
      margin: EdgeInsets.all(5), // Margine per separare gli elementi
      padding: EdgeInsets.all(10), // Padding per contenitore
      decoration: BoxDecoration(
        color: Colors.blue.shade50, // Colore di sfondo chiaro
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2), // Ombra leggera
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ingredient.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${quantity}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.redAccent),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
