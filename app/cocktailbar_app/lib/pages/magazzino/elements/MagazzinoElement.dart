import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MagazzinoElement extends StatelessWidget {
  final String nome;
  final int idMagazzino;
  final int idElemento;

  const MagazzinoElement({
    super.key,
    required this.nome,
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
      child: GFCard(
        color: const Color.fromARGB(255, 26, 5, 146),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        title: GFListTile(
          titleText: nome,
          color: GFColors.WHITE,
        ),
      ),
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // Impostare la larghezza desiderata
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.7, // 70% della larghezza dello schermo
            height: MediaQuery.of(context).size.height *
                0.5, // Altezza fissa o percentuale
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.asset('assets/image.png'), // Immagine
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nome,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            //da cambiare
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the , when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
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
                      Navigator.of(context).pop();
                    },
                    child: const Text('Chiudi'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
