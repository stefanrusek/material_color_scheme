import 'package:flutter/material.dart';

import 'color_utils.dart';

class MaterialColorGenerator {

  Map<int, Color> generateSwatch(Color base) {
    var darker = darken(base);
    var lighter = lighten(base);
    return {
      50: tweak(base, 1, 1, 0.0, 0.2,
          lighter: lighter, darker: darker),
      100: tweak(base, 1, 0.95, 0.0, 0.4,
          lighter: lighter, darker: darker),
      200: tweak(base, 1, 0.97, 0.0, 0.7,
          lighter: lighter, darker: darker),
      300: tweak(base, 1, 0.91, 0.1, 0.90, // blue 0.9
          lighter: lighter, darker: darker),
      400: tweak(base, 1, 0.97, 0.55, 0.97,
          lighter: lighter, darker: darker),
      500: tweak(base, 1, 1, 1, 1,
          lighter: lighter, darker: darker),
      600: tweak(base, 0.973, 0.7, 0.9, 0.97,
          lighter: lighter, darker: darker),
      700: tweak(base, 0.92, 0.45, 0.7, 0.97,
          lighter: lighter, darker: darker),
      800: tweak(base, 0.87, 0.2, 0.0, 1,
          lighter: lighter, darker: darker),
      900: tweak(base, 0.8, 0.09, 0.4, 0.98,
          lighter: lighter, darker: darker)
    };
  }

  Map<int, Color> generateAccentSwatch(Color hex) {
    var baseDark = darken(hex);
    var hslBase = HSLColor.fromColor(hex);
    var baseTriad = hslBase.withHue((hslBase.hue + 270) % 360).toColor();
    var accentBase = HSLColor.fromColor(Color.lerp(baseDark, baseTriad, 0.15));
    return {
      100: accentBase
          .withSaturation((accentBase.saturation + 0.80).clamp(0.0, 1.0))
          .withLightness((accentBase.lightness + 0.65).clamp(0.0, 1.0))
          .toColor(),
      200: accentBase
          .withSaturation((accentBase.saturation + 0.80).clamp(0.0, 1.0))
          .withLightness((accentBase.lightness + 0.55).clamp(0.0, 1.0))
          .toColor(),
      400: accentBase
          .withSaturation((accentBase.saturation + 1.00).clamp(0.0, 1.0))
          .withLightness((accentBase.lightness + 0.45).clamp(0.0, 1.0))
          .toColor(),
      700: accentBase
          .withSaturation((accentBase.saturation + 1.00).clamp(0.0, 1.0))
          .withLightness((accentBase.lightness + 0.40).clamp(0.0, 1.0))
          .toColor(),
    };
  }
}
