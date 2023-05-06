import 'package:flutter/material.dart';

class DropButton extends StatefulWidget {
  const DropButton({
    super.key,
    required this.title,
    required this.items,
    required this.icons,
    required this.onDropButtonConfirm,
  });
  final String title;
  final List<String> items;
  final List<Icon> icons;
  final DropButtonCallback onDropButtonConfirm;

  @override
  State<DropButton> createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  late String dropdownValue = widget.items.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: dropdownValue == widget.items[0]
          ? widget.icons[0]
          : dropdownValue == widget.items[1]
              ? widget.icons[1]
              : widget.icons[2],
      iconEnabledColor: Colors.blue,
      iconDisabledColor: Colors.blue,
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onDropButtonConfirm(value);
        });
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

typedef DropButtonCallback = void Function(String value);
