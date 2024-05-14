import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CheckableElement extends StatefulWidget {
  final bool initialValue;
  final String elementName;

  const CheckableElement({
    super.key,
    required this.initialValue,
    required this.elementName,
  });

  @override
  CheckableElementState createState() => CheckableElementState();
}

class CheckableElementState extends State<CheckableElement> {
  late bool _isChecked;
  late String _elementName;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
    _elementName = widget.elementName;
  }

  bool getValore() {
    return _isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20), // Ridotto per esempio
      child: Row(
        children: [
          GFCheckbox(
            activeBgColor: GFColors.SUCCESS,
            size: GFSize.LARGE,
            type: GFCheckboxType.circle,
            onChanged: (value) {
              setState(() {
                _isChecked = value;
                print('Checkbox value changed: $value');
              });
            },
            value: _isChecked,
            inactiveIcon: null,
          ),
          const SizedBox(
              width: 8), // Spazio tra la casella di controllo e il testo
          Text(_elementName), // Testo accanto alla casella di controllo
        ],
      ),
    );
  }
}
