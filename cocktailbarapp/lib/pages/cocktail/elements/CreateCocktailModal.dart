import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/elements/checkable_element.dart';
import 'package:cocktailbarapp/pages/cocktail/elements/CreateIngredientModal.dart';
import 'package:cocktailbarapp/pages/cocktail/elements/IngredientItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../classes/Ingredient.dart';

List<Ingredient> ingredienti = [];

class CreateCocktailModal extends StatefulWidget {
  CreateCocktailModal({Key? key}) : super(key: key);

  @override
  _CreateCocktailModalState createState() => _CreateCocktailModalState();
}

class _CreateCocktailModalState extends State<CreateCocktailModal> {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerDescrizione = TextEditingController();
  TextEditingController controllerGarnish = TextEditingController();
  TextEditingController controllerMetodo = TextEditingController();
  CheckableElement ghiaccio= new CheckableElement(initialValue: false, elementName: "ghiaccio");
  

  void _updateLists() {
    setState(
        () {}); // Aggiorna lo stato del widget quando le liste vengono modificate
  }

  _openIngredientModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateIngredientModal(
          ingredients: ingredienti,
          updateLists: _updateLists,
        );
      },
    );
  }

  void _deleteIngredient(Ingredient ingredient) {
    setState(() {
      ingredienti.remove(ingredient);
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width *
            0.7, // 70% della larghezza dello schermo
        height: MediaQuery.of(context).size.height *
            0.7, // Altezza fissa o percentuale
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Image.asset('assets/image.png'), // Immagine
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Crea un cocktail",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      TextField(
                        controller: controllerNome,
                        decoration: const InputDecoration(
                          labelText: 'Nome cocktail',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controllerDescrizione,
                        decoration: const InputDecoration(
                          labelText: 'Descrizione',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controllerMetodo,
                        decoration: const InputDecoration(
                          labelText: 'Metodo',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controllerGarnish,
                        decoration: const InputDecoration(
                          labelText: 'Garnish',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      ghiaccio,
                      const SizedBox(height: 10),
                      Wrap(
                        children: [
                          for (var ingrediente in ingredienti)
                            //Aggiungi IngredientItem
                            IngredientItem(
                              ingredient: ingrediente,
                              onDelete: () => _deleteIngredient(ingrediente),),
                          GestureDetector(
                            onTap: () => _openIngredientModal(context),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.add),
                            ),
                          )
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            List<Ingredient> ingredientsCopy = List.from(ingredienti);
                            try {
                              FirebaseFirestore.instance
                                  .collection('Cocktails')
                                  .add({
                                'name': controllerNome.text,
                                'description': controllerDescrizione.text,
                                'garnish': controllerGarnish.text,
                                'method': controllerMetodo.text,
                                'ice': true,
                              }).then((cocktailDocRef) {
                                print(ingredienti);
                                for (var ingrediente in ingredientsCopy) {
                                  cocktailDocRef.collection('ingredients').add({
                                    'name': ingrediente.name,
                                    'quantity': ingrediente.qty
                                  }).then((_) {
                                    print('Ingrediente aggiunto con successo. Nome Ingrediente ${ingrediente.name}');
                                  }).catchError((error) {
                                    print(
                                        'Errore durante l\'aggiunta dell\'ingrediente: $error');
                                  });
                                }
                                print(
                                    'Dati inseriti con successo nel database Firebase.');
                              }).catchError((error) {
                                print(
                                    'Errore durante l\'inserimento dei dati nel database Firebase: $error');
                              });
                            } catch (error) {
                              print(
                                  'Errore durante l\'inserimento dei dati nel database Firebase: $error');
                            }
                            ingredienti.clear();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Aggiungi'))
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(), // Aggiunge spazio flessibile tra il contenuto e il pulsante
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  ingredienti.clear();
                  Navigator.of(context).pop();
                },
                child: const Text('Chiudi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
