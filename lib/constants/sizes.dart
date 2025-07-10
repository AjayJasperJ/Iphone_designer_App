import 'package:flutter/material.dart';

class sizes {
  static double displayLarge(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge?.fontSize ?? 48;
  static double displayMedium(BuildContext context) =>
      Theme.of(context).textTheme.displayMedium?.fontSize ?? 36;
  static double displaySmall(BuildContext context) =>
      Theme.of(context).textTheme.displaySmall?.fontSize ?? 24;

  static double headlineLarge(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge?.fontSize ?? 32;
  static double headlineMedium(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium?.fontSize ?? 28;
  static double headlineSmall(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall?.fontSize ?? 24;

  static double titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge?.fontSize ?? 22;
  static double titleMedium(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium?.fontSize ?? 20;
  static double titleSmall(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall?.fontSize ?? 18;

  static double bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge?.fontSize ?? 16;
  static double bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14;
  static double bodySmall(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall?.fontSize ?? 12;

  static double labelLarge(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge?.fontSize ?? 14;
  static double labelMedium(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium?.fontSize ?? 12;
  static double labelSmall(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall?.fontSize ?? 10;
}
