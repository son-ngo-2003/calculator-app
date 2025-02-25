import 'package:flutter/material.dart';

class CalculatorKey extends StatelessWidget {
  const CalculatorKey({super.key, this.text, this.icon, this.onTap, this.textColor, this.backgroundColor, this.fontSize});

  final String? text;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColorFinal = textColor ?? theme.textTheme.bodyLarge?.color;
    final backgroundColorFinal = backgroundColor ?? theme.colorScheme.surface;
    final fontSizeFinal = fontSize ?? (theme.textTheme.titleLarge?.fontSize ?? 30.0) * 0.9;

    var content = text != null 
                  ? Text(text!,
                      style: TextStyle( fontSize: fontSizeFinal, color: textColorFinal, fontWeight: FontWeight.w500 )
                    )
                  : icon != null
                    ? Icon(icon, size: fontSizeFinal, color: textColorFinal, weight: 700 )
                    : SizedBox(); // avoid error when null

    return Material(
      borderRadius: BorderRadius.circular(15),
      color: backgroundColorFinal,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Center( 
          child: content,
        ),
      ),
    );

  }
}