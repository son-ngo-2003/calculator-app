

import 'package:math_expressions/math_expressions.dart';

bool isNumericString(String value) {
  return (value == 'ANS') || value == 'π' || value == 'e' || (double.tryParse(value) != null);
}

bool isFunctionString(String value) {
  return ['sin', 'cos', 'tan', 'log', 'ln', 'sqrt'].contains(value);
}

String? toStringAsFixed(double? n, int fractionDigits) {
  // like num.toStringAsFixed() but remove trailing zeros
  if (n == null) return null;
  String value = n.toStringAsFixed(fractionDigits);
  if (value.contains('.')) {
    while (value.endsWith('0')) {
      value = value.substring(0, value.length - 1);
    }
    if (value.endsWith('.')) {
      value = value.substring(0, value.length - 1);
    }
  }
  return value;
}

double evaluateFormule(String expression, double? ans) {
  try {
    ExpressionParser p = GrammarParser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    if (ans != null) {
      cm.bindVariableName('ANS', Number(ans));
    }
    final result = exp.evaluate(EvaluationType.REAL, cm);
    if (result.isNaN || result.isInfinite) {
      throw Exception('Semantic error');
    }
    return result;

  } catch (e) {
    throw Exception('$e');
  }
}












// String? getOppositeOperator(String operator) {
//   if (operator == '+') return '-';
//   if (operator == '-') return '+';
//   if (operator == '*') return '/';
//   if (operator == '/') return '*';
//   return null;
// }

// List<String> refactorFormule(List<String> formuleElements) {
//   if (formuleElements.isEmpty) return [];

//   var refactored = formuleElements.map( (e) {
//     // replace ANS with the last result
//     if (e == 'ANS') {
//       return '__ANS__';
//     }
//     return e;
//   }).toList();

//   // change % to [ '/' and '100']
//   for (var i = 0; i < refactored.length; i++) {
//     if (refactored[i] == '%') {
//       refactored[i] = '/';
//       refactored.insert(i + 1, '100');
//     }
//   }

//   // combine all +, - consecutive
//   int i = 1;
//   while (i < refactored.length) {
//     if (['+', '-'].contains(refactored[i]) && ['+', '-'].contains(refactored[i - 1])) {
//       refactored[i - 1] = refactored[i] == '+' ? refactored[i - 1] : getOppositeOperator(refactored[i - 1])!;
//       refactored.removeAt(i);
//     } else {
//       i++;
//     }
//   }

//   // combine signe and number in the beginning
//   if (['+', '-'].contains(refactored.first)) {
//     refactored[1] = refactored.first == '+' ? refactored[1] : '-${refactored[1]}';
//     refactored.removeAt(0);
//   }

//   // combine signe and number
//   i = 2;
//   while (i < refactored.length) {
//     if (isNumericString(refactored[i]) && ['+', '-'].contains(refactored[i - 1]) && ['+', '-', '*', '/'].contains(refactored[i - 2])) {
//       refactored[i] = refactored[i-1] == '+' ? refactored[i] : '-${refactored[i]}';
//       refactored.removeAt(i-1);
//     } else {
//       i++;
//     }
//   }

//   return refactored;
// }

// bool isSyntaxCorrect(List<String> refactoredFormule) {
//   for (var i = 0; i < refactoredFormule.length - 1; i++) {

//     // check if there are 2 numbers consecutive in the formule
//     if (isNumericString(refactoredFormule[i]) && isNumericString(refactoredFormule[i + 1])) {
//       return false;
//     }

//     // check if there are 2 operators consecutive in the formule
//     if (['*', '/', '+', '-'].contains(refactoredFormule[i]) && ['*', '/', '+', '-'].contains(refactoredFormule[i + 1])) {
//       return false;
//     }
//   }

//   // check if the formule ends with an operator
//   if (['*', '/', '+', '-'].contains(refactoredFormule.last)) {
//     return false;
//   }

//   // check if the formule starts with an operator
//   if (['*', '/', '+', '-'].contains(refactoredFormule.first)) {
//     return false;
//   }

//   return true;
// }

// List<dynamic> convertToNumeric(List<dynamic> refactoredFormule, double? ans) {
//   List<dynamic> converted = [];
//   for (var element in refactoredFormule) {
//     if (isNumericString(element)) {

//       if (element == '__ANS__') {
//         if (ans == null) {
//           throw Exception('Missing ANS');
//         } else {
//           converted.add(ans);
//           continue;
//         }
//       } 
        
//       converted.add(double.parse(element));
//       continue;
//     } 
//     converted.add(element);
//   }
//   return converted;
// }

// double evaluateFormule(List<String> formuleElements, double? ans) {
//   final refactoredFormule = refactorFormule(formuleElements);
//   if (!isSyntaxCorrect(refactoredFormule)) {
//     throw Exception('Syntax error');
//   }
  
//   List<dynamic> converted = convertToNumeric(refactoredFormule, ans);

//   // calculate * and /
//   int i = 0;
//   while (i < converted.length - 1) {
//     if (['*', '/'].contains(converted[i])) {
//       if (converted[i + 1] == 0 && converted[i] == '/') {
//         throw Exception('Division by zero');
//       }

//       double result = converted[i] == '*'
//                       ? converted[i - 1] * converted[i + 1]
//                       : converted[i - 1] / converted[i + 1];

//       converted.removeRange(i - 1, i + 2);
//       converted.insert(i - 1, result);
//     } else {
//       i++;
//     }
//   }

//   // calculate + and -
//   i = 0;
//   while (i < converted.length - 1) {
//     if (['+', '-'].contains(converted[i])) {
//       double result = converted[i] == '+'
//                       ? converted[i - 1] + converted[i + 1]
//                       : converted[i - 1] - converted[i + 1];

//       converted.removeRange(i - 1, i + 2);
//       converted.insert(i - 1, result);
//     } else {
//       i++;
//     }
//   }

//   return converted[0];
// }

