import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SizedIconButton extends StatelessWidget {
  const SizedIconButton({super.key, this.icon, this.svgAssetsName, this.onPressed, this.size = 50.0, this.color, this.iconColor});

  final IconData? icon;
  final String? svgAssetsName;
  final VoidCallback? onPressed;

  final double size;
  final Color? color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = size * 0.6;
    final iconColorFinal = iconColor?? theme.textTheme.bodyLarge?.color ?? theme.colorScheme.primary;

    final iconFinal = 
      icon != null ? Icon(icon, size: iconSize, color: iconColorFinal) :
      svgAssetsName != null ? SvgPicture.asset(svgAssetsName!, semanticsLabel: 'Dart Logo', width: iconSize, height: iconSize, colorFilter: ColorFilter.mode(iconColorFinal, BlendMode.srcIn),) :
      null;

    return SizedBox(
      width: size,
      height: size,
      child: Material(
        borderRadius: BorderRadius.circular(size / 2),
        color: color,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),
          child: Center( 
            child: iconFinal,
          ),
        ),
      )
    );
  }
}