import 'package:flutter/material.dart';

class Textbuttonwidget extends StatelessWidget {
  const Textbuttonwidget(
      {super.key, required this.onpressed, required this.onpressedname});
  final void Function() onpressed;
  final String onpressedname;
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {}, child: Text(onpressedname));
  }
}
