import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomComboBox extends StatefulWidget {
  final CollectionReference collectionReference;
  final void Function(String?)? onChanged;

  CustomComboBox({required this.collectionReference, this.onChanged});

  @override
  _CustomComboBoxState createState() => _CustomComboBoxState();
}

class _CustomComboBoxState extends State<CustomComboBox> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.collectionReference.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        List<DropdownMenuItem<String>> items = snapshot.data!.docs.map((doc) {
          return DropdownMenuItem<String>(
            value: doc['name'], // assuming 'name' field is present in documents
            child: Text(doc['name']),
          );
        }).toList();

        return DropdownButton<String>(
          value: selectedValue,
          items: items,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          hint: Text('Seleziona un tipo di bicchiere'),
        );
      },
    );
  }
}
