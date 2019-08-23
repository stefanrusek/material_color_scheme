library material_color_scheme;

import 'package:flutter/material.dart';
import 'package:material_color_scheme/src/material_color_generator.dart';

MaterialColor generateSwatch(Color src) =>
    MaterialColor(src.value, MaterialColorGenerator().generateSwatch(src));

MaterialAccentColor generateAccent(Color src) => MaterialAccentColor(
    src.value, MaterialColorGenerator().generateAccentSwatch(src));
