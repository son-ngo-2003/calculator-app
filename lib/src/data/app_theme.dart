import 'package:flutter/material.dart';

const seedColor = Colors.teal;

final monochromeLightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: seedColor, 
  dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
);

final mainLightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: seedColor,
  dynamicSchemeVariant: DynamicSchemeVariant.fidelity,

  surfaceDim: monochromeLightColorScheme.surfaceDim,
  surface: monochromeLightColorScheme.surface,
  surfaceBright: monochromeLightColorScheme.surfaceBright,
  surfaceContainerLowest: monochromeLightColorScheme.surfaceContainerLowest,
  surfaceContainerLow: monochromeLightColorScheme.surfaceContainerLow,
  surfaceContainer: monochromeLightColorScheme.surfaceContainer,
  surfaceContainerHigh: monochromeLightColorScheme.surfaceContainerHigh,
  surfaceContainerHighest: monochromeLightColorScheme.surfaceContainerHighest,
  onSurface: monochromeLightColorScheme.onSurface,
  onSurfaceVariant: monochromeLightColorScheme.onSurfaceVariant, 
);

final monochromeDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: seedColor,
  dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
);

final mainDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: seedColor,
  dynamicSchemeVariant: DynamicSchemeVariant.fidelity,

  surfaceDim: monochromeDarkColorScheme.surfaceDim,
  surface: monochromeDarkColorScheme.surface,
  surfaceBright: monochromeDarkColorScheme.surfaceBright,
  surfaceContainerLowest: monochromeDarkColorScheme.surfaceContainerLowest,
  surfaceContainerLow: monochromeDarkColorScheme.surfaceContainerLow,
  surfaceContainer: monochromeDarkColorScheme.surfaceContainer,
  surfaceContainerHigh: monochromeDarkColorScheme.surfaceContainerHigh,
  surfaceContainerHighest: monochromeDarkColorScheme.surfaceContainerHighest,
  onSurface: monochromeDarkColorScheme.onSurface,
  onSurfaceVariant: monochromeDarkColorScheme.onSurfaceVariant,
);

final ligthTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: mainLightColorScheme,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: mainDarkColorScheme,
);