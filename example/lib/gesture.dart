import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_androssy_kits/flutter_androssy_kits.dart';

class GestureExample extends StatelessWidget {
  const GestureExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AndrossyButton(
              onTap: () => log("onTap"),
              clickEffects: [
                GestureAnimation.fade(target: 0.5),
                GestureAnimation.scale(target: 0.9),
              ],
              text: "Click",
              iconOnly: true,
              // icon: Icons.phone,
            ),
          ],
        ),
      ),
    );
  }
}
