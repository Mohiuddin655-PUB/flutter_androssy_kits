import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_androssy_kits/flutter_androssy_kits.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'gesture.dart';

void main() {
  Androssy.init(
    cachedNetworkImageBuilder: (context, config) {
      return CachedNetworkImage(imageUrl: config.imageUrl);
    },
    svgImageBuilder: (context, config) {
      switch (config.source) {
        case AndrossyContentSource.asset:
          return SvgPicture.asset(config.assetName);
        case AndrossyContentSource.file:
          return SvgPicture.file(config.file);
        case AndrossyContentSource.memory:
          return SvgPicture.memory(config.bytes);
        case AndrossyContentSource.network:
          return SvgPicture.network(config.url);
        case AndrossyContentSource.string:
          return SvgPicture.string(config.string);
      }
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Androssy Kits',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        buttonTheme: ButtonThemeData(
          padding: const EdgeInsets.only(
            left: 24,
            right: 20,
            top: 12,
            bottom: 12,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            primary: Colors.blue,
            secondary: Colors.blue.withOpacity(0.1),
            tertiary: Colors.grey.shade200,
            onPrimary: Colors.white,
            onSecondary: Colors.blue,
            onTertiary: Colors.black38,
          ),
        ),
      ),
      home: const GestureExample(),
    );
  }
}
