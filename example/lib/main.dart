import 'package:flutter/material.dart';
import 'package:material_color_scheme/material_color_scheme.dart';

main() => runApp(ColorApp());

class ColorApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ColorAppState();
}

class ColorAppState extends State<ColorApp> {
  Color themeBase = Color(0xffffffff);

  setThemeColor(Color color) {
    setState(() {
      themeBase = color;
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
          title: "Color Demo",
          theme: ThemeData(
            primarySwatch: generateSwatch(themeBase),
          ),
          routes: {
            "/": (context) => Scaffold(
                  appBar: AppBar(
                    title: Text("Color Demo"),
                  ),
                  body: ListView(
                    children: <Widget>[
                      ColorTile(
                          swatch: generateSwatch(themeBase),
                          onTap: setThemeColor),
                      ColorTile(
                          swatch: generateSwatch(Color(0xffffffff)),
                          onTap: setThemeColor),
                      ColorTile(
                          swatch: generateSwatch(Color(0xff000000)),
                          onTap: setThemeColor),
                      ColorTile(
                          swatch: generateSwatch(Color(0xffff0000)),
                          onTap: setThemeColor),
                      ColorTile(
                          swatch: generateSwatch(Color(0xffff7f00)),
                          onTap: setThemeColor),
                      ColorTile(
                          swatch: generateSwatch(Color(0xffffff00)),
                          onTap: setThemeColor),
                      ColorTile(
                          swatch: generateSwatch(Color(0xff7fff00)),
                          onTap: setThemeColor),
                      ColorTile(
                          swatch: generateSwatch(Color(0xff00ff00)),
                          onTap: setThemeColor),
                      ColorTile(
                          swatch: generateSwatch(Color(0xff00ff7f)),
                          onTap: setThemeColor),
                      ColorTile(
                          swatch: generateSwatch(Color(0xff00ffff)),
                          onTap: setThemeColor),
                      ColorTile(
                          swatch: generateSwatch(Color(0xff007fff)),
                          onTap: setThemeColor),
                      ColorTile(
                          swatch: generateSwatch(Color(0xff0000ff)),
                          onTap: setThemeColor)
                    ],
                  ),
                )
          });
}

class ColorTile extends StatelessWidget {
  final MaterialColor swatch;
  final ValueChanged<Color> onTap;

  const ColorTile({Key? key, required this.swatch, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            for (var color in colors)
              Expanded(child:
              GestureDetector(
                  onTap: () => onTap(color),
                  child: DecoratedBox(decoration: BoxDecoration(color: color), child: Text(" "))))
          ],
        ),
      );

  List<Color> get colors => [
        swatch[50]!,
        swatch[100]!,
        swatch[200]!,
        swatch[300]!,
        swatch[400]!,
        swatch[500]!,
        swatch[600]!,
        swatch[700]!,
        swatch[800]!,
        swatch[900]!,
      ];
}
