import 'package:flutter/material.dart';

class MyInputButton extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function validator;
  final List<Map<String, dynamic>> datas;
  Function onChanged;

  MyInputButton({
    this.title,
    this.controller,
    this.validator,
    this.datas,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    if (onChanged == null) {
      onChanged = (value) {
        controller.text = value.toString();
      };
    }
    return Material(
      elevation: 1,
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: DropdownButtonFormField(
          validator: validator,
          decoration: InputDecoration(
              labelText: "$title",
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
          items: datas.map((Map<String, dynamic> value) {
            return new DropdownMenuItem<String>(
              value: value['id'],
              child: Text(value['nama']),
            );
          }).toList(),
          onChanged: onChanged,
          value: controller.text ?? '',
          isExpanded: true,
          hint: Text("Pilih $title"),
        ),
      ),
    );
  }
}
