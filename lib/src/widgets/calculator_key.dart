import 'package:flutter/material.dart';
import 'package:second_app/src/widgets/custom_animated_color_container.dart';

class CalculatorKey extends StatelessWidget {
  const CalculatorKey({super.key, this.text, this.icon, this.onTap, this.textColor, this.backgroundColor, this.fontSize, this.alternativeText, this.alternativeIcon, this.usingAlternative = false});

  final String? text;
  final IconData? icon;

  final VoidCallback? onTap;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;

  final String? alternativeText;
  final IconData? alternativeIcon;
  final bool usingAlternative;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColorFinal = textColor ?? theme.textTheme.bodyLarge?.color;
    final backgroundColorFinal = backgroundColor ?? theme.colorScheme.surface;
    final fontSizeFinal = fontSize ?? (theme.textTheme.titleLarge?.fontSize ?? 30.0) * 0.9;

    var content = 
    !usingAlternative
    ? text != null 
        ? Text(text!,
            style: TextStyle( fontSize: fontSizeFinal, color: textColorFinal, fontWeight: FontWeight.w500 )
          )
        : icon != null
          ? Icon(icon, size: fontSizeFinal, color: textColorFinal, weight: 700 )
          : SizedBox()
    : text != null
        ? Text(alternativeText!,
            style: TextStyle( fontSize: fontSizeFinal, color: textColorFinal, fontWeight: FontWeight.w500 )
          )
        : icon != null
            ? Icon(alternativeIcon, size: fontSizeFinal, color: textColorFinal, weight: 700 )
            : SizedBox(); // avoid error when null

    return CustomAnimatedColorContainer(
      borderRadius: BorderRadius.circular(15),
      duration: const Duration(milliseconds: 800),
      color: backgroundColorFinal,
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Center( 
            child: content,
          ),
        ),
      ),
    );

  }
}