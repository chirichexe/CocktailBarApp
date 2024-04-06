import 'package:flutter/material.dart';

class CheckableElement extends StatefulWidget {
  final bool initialValue;
  final String elementName;
  final void Function(bool) onChanged;

  const CheckableElement({
    Key? key,
    required this.initialValue,
    required this.elementName,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CheckableElementState createState() => _CheckableElementState();
}

class _CheckableElementState extends State<CheckableElement> {
  late bool _isChecked;
  late String _elementName;
  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
    _elementName = widget.elementName;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 550), // Spazio a sinistra della riga
      child: Row(
        children: [
          Checkbox(
            value: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = value!;
              });
              widget.onChanged(value!);
            },
          ),
          const SizedBox(
              width: 8), // Spazio tra la casella di controllo e il testo
          Text(_elementName), // Testo accanto alla casella di controllo
        ],
      ),
    );
  }
}
