import 'package:cocktailbar_app/pages/magazzino/elements/ListaMagazzini.dart';
import 'package:cocktailbar_app/pages/magazzino/elements/Magazzino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class newMagazzinoPage extends StatefulWidget {
  @override
  State<newMagazzinoPage> createState() => _MagazzinoState();
}

class _MagazzinoState extends State<newMagazzinoPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Magazzino'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('Magazzini').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<Map<String, dynamic>> magazzini = snapshot.data!.docs.map((DocumentSnapshot document) {
            return document.data() as Map<String, dynamic>;
          }).toList();

          return ListView.builder(
            itemCount: magazzini.length,
            itemBuilder: (context, index) {
              return Magazzino(
                id: magazzini[index]['id'] ?? '',
                nome: magazzini[index]['name'] ?? '',
                descrizione: magazzini[index]['description'] ?? '',
              );
            },
          );
        },
      ),
    );
  }
}
//PROVA GRIDVIEW VA SISTEMATO IL TIPO
/*import 'package:cocktailbar_app/pages/magazzino/elements/Magazzino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class newMagazzinoPage extends StatefulWidget {
  @override
  State<newMagazzinoPage> createState() => _MagazzinoState();
}

class _MagazzinoState extends State<newMagazzinoPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Magazzino'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('Magazzini').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<Map<String, dynamic>> magazzini = snapshot.data!.docs.map((DocumentSnapshot document) {
            return document.data() as Map<String, dynamic>;
          }).toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Set the number of columns here
              crossAxisSpacing: 10.0, // Set spacing between columns
              mainAxisSpacing: 10.0, // Set spacing between rows
            ),
            itemCount: magazzini.length,
            itemBuilder: (context, index) {
              return StreamBuilder<DocumentSnapshot>(
                stream: db.collection('Magazzini').doc(magazzini[index]['id']).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Text('Document does not exist');
                  }

                  return Magazzino(
                    id: magazzini[index]['id'] ?? '',
                    nome: magazzini[index]['name'] ?? '',
                    descrizione: magazzini[index]['description'] ?? '',
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
*/