import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:second_app/src/data/constants.dart';
import 'package:second_app/src/utils/formule.dart';

class FormuleModel extends ChangeNotifier {
  double? ans;
  List<String> inputValues = [];
  double? result;
  Exception? error;
  bool justGetError = false;

  String? get previousResult => toStringAsFixed(ans, numberDecimalDigitsShow);
  String get expressionDisplay => inputValues.join(' ');
  String? get errorMessage => error?.toString().substring(11); // remove 'Exception:'
  String? get formuleResult => toStringAsFixed(ans, numberDecimalDigitsShow);

  void addSymbol(String value) {
    if (value.isEmpty) return;
    if (result != null) {
      inputValues.clear();
      result = null;

      if (isFunctionString(value)) {
        inputValues
          ..add(value)
          ..add('(')
          ..add('ANS');
        return;
      } else if (!isNumericString(value)) { 
        inputValues.add('ANS');
      }  
    }

    // if the input is empty, add the value
    if (inputValues.isEmpty) {
      inputValues.add(value);
      notifyListeners();
      return;
    } 

    // if the last element is a number, and input is a number so add the value to the last element
    if (isNumericString(inputValues.last) && (isNumericString(value) || value == '.')) {
      inputValues[inputValues.length - 1] += value;
      notifyListeners();
      return;
    } 
    
    // other case
    inputValues.add(value);
    notifyListeners();
  }

  void removeLastSymbol() {
    if (inputValues.isEmpty) return; 

    if (isNumericString(inputValues.last) && inputValues.last.length > 1) {
      inputValues[inputValues.length - 1] = inputValues.last.substring(0, inputValues.last.length - 1);
      notifyListeners();
      return;
    }

    inputValues.removeLast();
    notifyListeners();
  }

  void clearDisplay() {
    inputValues.clear();
    result = null;
    notifyListeners();
  }

  (double, String)? calculateFormule() {
    try {
      result = evaluateFormule(expressionDisplay, ans);
      ans = result;
      return (result!, expressionDisplay);
    } catch (e) {
      error = e as Exception;
      justGetError = true;
      Future.delayed(Duration(milliseconds: 500), () {
        justGetError = false;
        notifyListeners();
      });

      developer.log('Error: ${error.toString()}');
      return null;
    } finally {
      notifyListeners();
    }
  }

  void clearError() {
    error = null;
    notifyListeners();
  }

  void setAns(double? value, {bool notify = true}) {
    ans = value;
    if (notify) notifyListeners();
  }
}