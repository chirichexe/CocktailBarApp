// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyFirebase extends StatefulWidget {
  const MyFirebase({Key? key}) : super(key: key);

  @override
  State<MyFirebase> createState() => _MyFirebaseState();
}

class _MyFirebaseState extends State<MyFirebase> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cocktails'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        //Accesso a una collezione di un database e query
        stream: db.collection('cocktails').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<Map<String, dynamic>> cocktails =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            return document.data() as Map<String, dynamic>;
          }).toList();

          return ListView.builder(
            itemCount: cocktails.length,
            itemBuilder: (context, index) {
              return ListTile(
                //Ottengo
                title: Text(cocktails[index]['name'] ?? ''),
                subtitle: Text(cocktails[index]['description'] ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}
