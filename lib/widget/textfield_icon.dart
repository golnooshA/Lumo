

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldIcon extends StatelessWidget{

  final IconData icon;
  final String hintText;

  const TextFieldIcon({super.key, required this.icon, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            icon: Icon(icon),
          ),
        ),
      );
  }

}


