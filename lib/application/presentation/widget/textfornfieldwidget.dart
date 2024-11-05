import 'package:flutter/material.dart';

class Textformfielwidget extends StatelessWidget {
  const Textformfielwidget(
      {super.key, required this.title, required this.titlecontroller});
  final String title;
  final TextEditingController titlecontroller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titlecontroller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 2, color: Colors.blue)),
          hintText: title),
    );
  }
}
