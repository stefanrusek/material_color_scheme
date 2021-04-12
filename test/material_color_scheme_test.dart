import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_color_scheme/src/color_utils.dart';
import 'package:material_color_scheme/src/material_color_generator.dart';

void main() {
  Color _multiply(Color rgb1, Color rgb2) => Color.fromARGB(
      -1,
      (rgb1.red * rgb2.red) ~/ 255,
      (rgb1.green * rgb2.green) ~/ 255,
      (rgb1.blue * rgb2.blue) ~/ 255);

  int wrongness(Color a, Color b) {
    return (a.red - b.red) * (a.red - b.red) +
        (a.blue - b.blue) * (a.blue - b.blue) +
        (a.green - b.green) * (a.green - b.green);
  }

  findBLerp(MaterialColor base, Color start, int shade) {
    var depth = 30;
    var blerpMin = 0.0;
    var blerpMax = 1.0;
    var black = Color(0xFF000000);
    var dark = _multiply(base, base); //Color(0xff000000);
    var target = base[shade]!;

    print(target);
    do {
      var blerpMid = (blerpMin + blerpMax) / 2;
      var mid = Color.lerp(black, start, blerpMid)!;
      print("pass ${12 - depth} -> $mid ${wrongness(mid, target)}");
      if (mid == target) return blerpMid;

      var blow = Color.lerp(black, start, blerpMin)!;
      var bhigh = Color.lerp(black, start, blerpMax)!;

      var wrongs = [
        [0, 1000000000],
        [1, 1000000000],
        [2, wrongness(blow, target)],
        [3, wrongness(bhigh, target)]
      ];
      wrongs.sort((a, b) => a[1].compareTo(b[1]));

      switch (wrongs[0][0]) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          blerpMax = blerpMid;
          break;
        case 3:
          blerpMin = blerpMid;
          break;
      }
    } while (depth-- > 0);

    return (blerpMin + blerpMax) / 2;
  }

  findLerp(MaterialColor base, int shade) {
    var depth = 15;
    var mlerpMin = 0.0;
    var mlerpMax = 1.0;
    var black = Color(0xFF000000);
    var dark = _multiply(base, base); //Color(0xff000000);
    var target = base[shade];
    double blerp;

    print(target);
    do {
      var mlerpMid = (mlerpMin + mlerpMax) / 2;
      blerp = findBLerp(base, Color.lerp(dark, base, mlerpMid)!, shade);
      var mid = Color.lerp(black, Color.lerp(dark, base, mlerpMid), blerp)!;
      print("pass ${12 - depth} -> $mid ${wrongness(mid, target!)}");
      if (mid == target) return [mlerpMid, blerp];

      var mlow = Color.lerp(black, Color.lerp(dark, base, mlerpMin),
          findBLerp(base, Color.lerp(dark, base, mlerpMin)!, shade))!;
      var mhigh = Color.lerp(black, Color.lerp(dark, base, mlerpMax),
          findBLerp(base, Color.lerp(dark, base, mlerpMax)!, shade))!;

      var wrongs = [
        [0, wrongness(mlow, target)],
        [1, wrongness(mhigh, target)]
      ];
      wrongs.sort((a, b) => a[1].compareTo(b[1]));

      switch (wrongs[0][0]) {
        case 0:
          mlerpMax = mlerpMid;
          break;
        case 1:
          mlerpMin = mlerpMid;
          break;
      }
    } while (depth-- > 0);

    return [(mlerpMin + mlerpMax) / 2, blerp];
  }

  search(int depth, double num, double offsetStep, int score(double)) {
    double bestOffset = 0;
    int best = 10000000;
    for (var i = 0, offset = 0.0; i < 10; i++, offset += offsetStep) {
      int value = score(num + offset);
      if (value < best) {
        bestOffset = offset;
        best = value;
      }
    }

    if (depth > 0) {
      return search(depth - 1, num + bestOffset, offsetStep / 10, score);
    } else
      return num + bestOffset;
  }

  findLerps(MaterialColor color, int shade) {
    var goal = color[shade]!;
    var df = 1.0, lf = 1.0, wf = 1.0, bf = 1.0;
    for (var tries = 0; tries < 10; tries++) {
      lf = search(
          10, 0, 0.1, (f) => wrongness(goal, tweak(color, bf, df, f, wf)));
      df = search(
          10, 0, 0.1, (f) => wrongness(goal, tweak(color, bf, f, lf, wf)));
      wf = search(
          10, 0, 0.1, (f) => wrongness(goal, tweak(color, bf, df, lf, f)));
      bf = search(
          10, 0, 0.1, (f) => wrongness(goal, tweak(color, f, df, lf, wf)));
    }

    return [shade, wrongness(goal, tweak(color, bf, df, lf, wf)), bf, df, lf, wf];
  }

  void testColorGen(MaterialColor expected, String name) {
    var gen = MaterialColorGenerator();
    var swatch = gen.generateSwatch(expected);

    for (var key in swatch.keys) {
      expect(wrongness(swatch[key]!, expected[key]!), lessThanOrEqualTo(1000),
          reason: "color $name[$key] should match");
    }
  }

  test("test colors match google's colors", () {
    testColorGen(Colors.blue, 'blue');
    testColorGen(Colors.green, "green");
    testColorGen(Colors.red, "red");
    testColorGen(Colors.purple, "purple");
    testColorGen(Colors.yellow, "yellow");
  });

  test("find lerp", () {
    var base = Colors.blue;
    expect([
      findLerps(base, 50),
      findLerps(base, 100),
      findLerps(base, 200),
      findLerps(base, 300),
      findLerps(base, 400),
      findLerps(base, 500),
      findLerps(base, 600),
      findLerps(base, 700),
      findLerps(base, 800),
      findLerps(base, 900),
    ], equals(0.8));
    expect(findLerp(base, 600), equals(0.8));
  });
}
