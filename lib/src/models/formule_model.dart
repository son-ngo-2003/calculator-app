import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:second_app/src/utils/formule.dart';

class FormuleModel extends ChangeNotifier {
  double? ans;
  List<String> inputValues = [];
  double? result;
  Exception? error;
  bool justGetError = false;

  String? get previousResult => ans?.toString();
  String get expressionDisplay => inputValues.join(' ');
  String? get errorMessage => error?.toString().substring(11); // remove 'Exception:'
  String? get formuleResult => result?.toString();

  void addChar(String value) {
    if (value.isEmpty) return;
    if (result != null) {
      inputValues.clear();
      if (!isNumericString(value)) { 
        inputValues.add('ANS');
      }
      result = null;
    }
    
    if (inputValues.isEmpty) {
      inputValues.add(value);
      notifyListeners();
      return;
    } 

    if (isNumericString(inputValues.last) && (isNumericString(value) || value == '.')) {
      inputValues[inputValues.length - 1] += value;
      notifyListeners();
      return;
    } 
    
    inputValues.add(value);
    notifyListeners();
  }

  void removeLastChar() {
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
      result = evaluateFormule(inputValues, ans);
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