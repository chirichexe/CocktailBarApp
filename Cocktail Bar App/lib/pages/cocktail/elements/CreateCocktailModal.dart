import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/elements/CheckableElement.dart';
import 'package:cocktailbarapp/pages/cocktail/elements/CreateIngredientModal.dart';
import 'package:cocktailbarapp/pages/cocktail/elements/CustomComboBox.dart';
import 'package:cocktailbarapp/pages/cocktail/elements/IngredientItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';
import '../classes/Ingredient.dart';

List<Ingredient> ingredienti = [];

class CreateCocktailModal extends StatefulWidget {
  CreateCocktailModal({Key? key}) : super(key: key);

  @override
  _CreateCocktailModalState createState() => _CreateCocktailModalState();
}

class _CreateCocktailModalState extends State<CreateCocktailModal> {
  final GlobalKey<CheckableElementState> _checkableElementKey =
      GlobalKey<CheckableElementState>();

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerDescrizione = TextEditingController();
  TextEditingController controllerGarnish = TextEditingController();
  TextEditingController controllerMetodo = TextEditingController();

  String? selectedGlassType;
  String? selectedIceType;

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

  String? getSelectedGlassType() {
    return selectedGlassType;
  }

  String? getSelectedIceType() {
    return selectedIceType;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Crea un cocktail",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: controllerNome,
                          decoration: InputDecoration(
                            labelText: 'Nome cocktail',
                            labelStyle: TextStyle(color: Colors.blueAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controllerDescrizione,
                          decoration: InputDecoration(
                            labelText: 'Descrizione',
                            labelStyle: TextStyle(color: Colors.blueAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controllerMetodo,
                          decoration: InputDecoration(
                            labelText: 'Metodo',
                            labelStyle: TextStyle(color: Colors.blueAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controllerGarnish,
                          decoration: InputDecoration(
                            labelText: 'Garnish',
                            labelStyle: TextStyle(color: Colors.blueAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                          const Text('Tipo di ghiaccio: ',
                          style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        CustomComboBox(
                          collectionReference:
                              FirebaseFirestore.instance.collection('Ghiacci'),
                          onChanged: (value) {
                            setState(() {
                              selectedIceType = value;
                            });
                          },
                        ),
                        const SizedBox(width: 30),
                        const Text('Tipo di bicchiere: ',
                          style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        CustomComboBox(
                          collectionReference: FirebaseFirestore.instance
                              .collection('Bicchieri'),
                          onChanged: (value) {
                            setState(() {
                              selectedGlassType = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: [
                            for (var ingrediente in ingredienti)
                              IngredientItem(
                                ingredient: ingrediente,
                                onDelete: () => _deleteIngredient(ingrediente),
                              ),
                            GestureDetector(
                              onTap: () => _openIngredientModal(context),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:
                                    Icon(Icons.add, color: Colors.blueAccent),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                          onPressed: () {
                            List<Ingredient> ingredientsCopy =
                                List.from(ingredienti);
                            try {
                              FirebaseFirestore.instance
                                  .collection('Cocktails')
                                  .add({
                                'name': controllerNome.text,
                                'description': controllerDescrizione.text,
                                'garnish': controllerGarnish.text,
                                'method': controllerMetodo.text,
                                'glass': getSelectedGlassType(),
                                'ice': getSelectedIceType(),
                              }).then((cocktailDocRef) {
                                print(ingredienti);
                                for (var ingrediente in ingredientsCopy) {
                                  cocktailDocRef.collection('ingredients').add({
                                    'name': ingrediente.name,
                                    'quantity': ingrediente.qty
                                  }).then((_) {
                                    print(
                                        'Ingrediente aggiunto con successo. Nome Ingrediente ${ingrediente.name}');
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
                          child: const Text('Aggiungi'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue, // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                          ),
                        ),
                        TextButton(
                  onPressed: () {
                    ingredienti.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Chiudi'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blueAccent,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  ),
                ),
                        ],
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
