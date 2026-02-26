import 'package:flutter/material.dart';

extension ContextExtension on BuildContext{
Color get primaryColor => Theme.of(this).colorScheme.primary;
Color get secondaryColor => Theme.of(this).colorScheme.secondary;
Color get tertiaryColor => Theme.of(this).colorScheme.tertiary;
Color get surfaceColor => Theme.of(this).colorScheme.surface;
TextTheme get textTheme => Theme.of(this).textTheme;
double get width=>MediaQuery.of(this).size.width;
double get height=>MediaQuery.of(this).size.height;
}