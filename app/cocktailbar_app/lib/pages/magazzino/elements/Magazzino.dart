import 'package:cocktailbar_app/pages/magazzino/elements/MagazzinoNavigator.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class Magazzino extends StatefulWidget {
  final String nome;
  final String descrizione;
  final int id;

  const Magazzino({
    super.key,
    required this.id,
    required this.descrizione,
    required this.nome,
  });

  @override
  State<Magazzino> createState() => _MagazzinoState();
}

class _MagazzinoState extends State<Magazzino> {
  @override
  Widget build(BuildContext context) {
    return GFCard(
      boxFit: BoxFit.cover,
      image: Image.asset('your asset image'),
      title: GFListTile(
        avatar: const GFAvatar(backgroundImage: AssetImage('your asset image')),
        title: Text(
          widget.nome,
          style: GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        subTitle: Text("Magazzino ${widget.nome}"),
      ),
      content: Text(widget.descrizione),
      buttonBar: GFButtonBar(
        children: <Widget>[
          GFButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MagazzinoNavigator(id: widget.id)),
              );
            },
            text: 'Apri',
          )
        ],
      ),
    );
  }
}
