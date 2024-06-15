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

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(10.0),
              iconEnabledColor: Colors.blueAccent[800],
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
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
              hint: const Text(
                'Seleziona un tipo',
                style: TextStyle(color: Colors.blueAccent),
              ),
              dropdownColor: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
