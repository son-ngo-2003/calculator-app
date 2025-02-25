import 'package:flutter/material.dart';

enum KeyType {
  number,
  operation,
  action
}

class CalculatorKeyItem {
  final String label; //label is for recognize the key (not for showing)
  final String? text; //text is for showing the key (more priority than icon)
  final IconData? icon; //iconData is for showing the key (less priority than text)
  final KeyType keyType; //determine the type of key (number, operation, action)

  CalculatorKeyItem({
    required this.label,
    this.text,
    this.icon,
    required this.keyType,
  });
}

