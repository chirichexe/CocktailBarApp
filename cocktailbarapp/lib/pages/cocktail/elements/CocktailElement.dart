import 'package:cocktailbarapp/pages/cocktail/elements/CocktailElementModal.dart';
import 'package:flutter/material.dart';

class CocktailElement extends StatefulWidget {
  final String idElemento;
  final String nome;

  const CocktailElement({super.key, required this.idElemento, required this.nome});

  @override
  State<CocktailElement> createState() => _CocktailElementState();
}

class _CocktailElementState extends State<CocktailElement> {
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
                widget.nome,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
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
        return CocktailElementModal(
          idElemento: widget.idElemento,
        );
      },
    );
  }
}
