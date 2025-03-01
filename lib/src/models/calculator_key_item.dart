import 'package:flutter/material.dart';

enum KeyType {
  number,
  operation,
  action,
  function,
}

class CalculatorKeyItem {
  final String label; //label is for recognize the key (not for showing)
  final String? text; //text is for showing the key (more priority than icon)
  final IconData? icon; //iconData is for showing the key (less priority than text)
  final String? alternativeText; //alternativeText is for showing the key (more priority than alternativeIcon)
  final IconData? alternativeIcon; //alternativeIcon is for showing the key (less priority than alternativeText)
  final KeyType keyType; //determine the type of key (number, operation, action)

  CalculatorKeyItem({
    required this.label,
    this.text,
    this.icon,
    this.alternativeText,
    this.alternativeIcon,
    required this.keyType,
  });
}

