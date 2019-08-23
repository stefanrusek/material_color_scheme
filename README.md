# material_color_scheme

A tool for easily making material and flutter color schemes.

## Getting Started

Using this package is super easy. Just import it:

     import 'package:material_color_scheme/material_color_scheme.dart';

Then use it in your theme definition:

    ThemeData(
        primarySwatch: generateSwatch(primaryColor),
        primaryTextTheme: Typography(platform: platform).white,
        // secondary colors
        accentColor: generateSwatch(secondaryColor),
        accentTextTheme: Typography(platform: platform).white,
    )

