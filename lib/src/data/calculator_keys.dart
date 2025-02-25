import 'package:flutter/material.dart';
import 'package:second_app/src/models/calculator_key_item.dart';

List<CalculatorKeyItem> keyboardKeys = [
  CalculatorKeyItem(label: 'clear', text: 'C', keyType: KeyType.action),
  CalculatorKeyItem(label: 'delete', icon: Icons.backspace_outlined, keyType: KeyType.action),
  CalculatorKeyItem(label: '%', text: '%', keyType: KeyType.operation),
  CalculatorKeyItem(label: '/', text: '/', keyType: KeyType.operation),

  CalculatorKeyItem(label: '7', text: '7', keyType: KeyType.number),
  CalculatorKeyItem(label: '8', text: '8', keyType: KeyType.number),
  CalculatorKeyItem(label: '9', text: '9', keyType: KeyType.number),
  CalculatorKeyItem(label: '*', text: '*', keyType: KeyType.operation),

  CalculatorKeyItem(label: '4', text: '4', keyType: KeyType.number),
  CalculatorKeyItem(label: '5', text: '5', keyType: KeyType.number),
  CalculatorKeyItem(label: '6', text: '6', keyType: KeyType.number),
  CalculatorKeyItem(label: '-', text: '-', keyType: KeyType.operation),

  CalculatorKeyItem(label: '1', text: '1', keyType: KeyType.number),
  CalculatorKeyItem(label: '2', text: '2', keyType: KeyType.number),
  CalculatorKeyItem(label: '3', text: '3', keyType: KeyType.number),
  CalculatorKeyItem(label: '+', text: '+', keyType: KeyType.operation),

  CalculatorKeyItem(label: 'ANS', text: 'ANS', keyType: KeyType.operation),
  CalculatorKeyItem(label: '0', text: '0', keyType: KeyType.number),
  CalculatorKeyItem(label: '.', text: '.', keyType: KeyType.operation),
  CalculatorKeyItem(label: 'equal', text: '=', keyType: KeyType.action),
];