import 'package:flutter/material.dart';

import '../design/design_config.dart';

class IconText extends StatelessWidget{

  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const IconText({super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Row(
        children:  [
          Icon(icon, size: 20),
          SizedBox(width: 8),
          Text(text,style: TextStyle(fontSize: DesignConfig.textSize)),
        ],
      ),
    );
  }


}