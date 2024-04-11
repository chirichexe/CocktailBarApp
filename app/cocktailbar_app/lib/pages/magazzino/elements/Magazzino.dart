import "package:cocktailbar_app/pages/magazzino/elements/magazzinoNavigator.dart";
import "package:flutter/material.dart";
import "package:getwidget/getwidget.dart";
import 'package:google_fonts/google_fonts.dart';

class Magazzino extends StatefulWidget {
  final String nome;
  final String descrizione;

  const Magazzino({super.key, required this.descrizione, required this.nome});

  @override
  State<Magazzino> createState() => _MagazzinoState();
}

class _MagazzinoState extends State<Magazzino> {
  String nome = "";
  String descrizione = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nome = widget.nome;
    descrizione = widget.descrizione;
  }

  @override
  Widget build(BuildContext context) {
    return GFCard(
      boxFit: BoxFit.cover,
      image: Image.asset('your asset image'),
      title: GFListTile(
        avatar: GFAvatar(
          backgroundImage: AssetImage('your asset image'),
        ),
        title: Text(
          nome,
          style: GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        subTitle: Text(descrizione),
      ),
      content: Text("Some quick example text to build on the card"),
      buttonBar: GFButtonBar(
        children: <Widget>[
          GFButton(
            //DA CAMBIARE
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MagazzinoNavigator(
                        elementName: "Gin", elementsNumber: 5)),
              );
            },
            text: 'Apri',
          )
        ],
      ),
    );
  }
}
