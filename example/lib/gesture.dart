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
              onClick: (context) {
                log("onClick");
              },
              clickEffect: const GestureClickEffect.fade(
                lowerBound: 0.5,
                upperBound: 1,
              ),
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
