import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_androssy_kits/flutter_androssy_kits.dart';

const _kStory = '''
Once upon a time, in a forest filled with towering trees and babbling brooks, lived a sly fox named Finley. Finley was known throughout the forest for his cunning wit and ability to outsmart just about anyone.
One day, Finley was feeling rather hungry. He had been out hunting all morning, but luck hadn't been on his side. His stomach grumbled loudly, reminding him of his empty belly. Just as he was about to give up, he spotted a plump rabbit hopping through the underbrush.
Finley's eyes gleamed with mischief. He crouched low to the ground, his bushy tail twitching with anticipation. Slowly, he crept closer to the unsuspecting rabbit, careful not to make a sound.
Just as he was about to pounce, a loud SNAP echoed through the forest. Finley froze, his ears perked up. He looked around and saw a young boy, no older than ten, standing nearby with a slingshot in his hand. The boy had been practicing his aim and had accidentally hit a branch, causing the loud noise.
Finley, startled and annoyed, decided to abandon his hunt and confront the boy. He stood tall, his fur bristling, and let out a sharp bark. The boy, surprised to see a talking fox, stumbled backward.
"Why did you scare away my lunch?" Finley demanded, his voice a mix of annoyance and amusement.
The boy, still a bit shaken, stammered, "I-I didn't mean to. I was just practicing with my slingshot."
Finley narrowed his eyes. "Well, your practice cost me a meal. Now what are you going to do about it?"
The boy, feeling guilty, offered Finley the apple he had brought for a snack. Finley, though still a bit grumpy, couldn't resist the juicy red apple. He took it from the boy and, with a sly grin, said, "This will do for now. But next time, be more careful."
And with that, Finley trotted off into the forest, enjoying his apple and chuckling to himself. He knew he would find another rabbit to chase soon enough. After all, he was Finley the fox, and he always had a trick or two up his sleeve.
''';

const imageUri =
    "https://i0.wp.com/picjumbo.com/wp-content/uploads/beautiful-nature-mountain-scenery-with-flowers-free-photo.jpg?w=600&quality=80";

class ViewExample extends StatelessWidget {
  const ViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.green,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/bg.jpg"),
          ),
        ),
        child: Stack(
          children: [
            AndrossyView(
              width: 300,
              height: 300,
              alignment: Alignment.center,
              shaderGradient: const LinearGradient(
                colors: Colors.primaries,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              backdropFilter: ImageFilter.blur(
                sigmaX: 50,
                sigmaY: 50,
              ),
              transform: Matrix4.rotationZ(0.5),
              transformAlignment: Alignment.center,
              margin: const EdgeInsets.all(50),
              padding: const EdgeInsets.all(50),
              clipConfig: AndrossyDockConfig(
                style: PaintingStyle.fill,
                sides: const DockedArcSides(
                  bottom: DockedArcSide.inner,
                  right: DockedArcSide.outer,
                ),
                borderRadius: BorderRadius.circular(25),
                color: Colors.black,
                strokeWidth: 5,
              ),
              onRenderedSize: (size) {
                log("SIZE: $size");
              },
              child: const Text(
                "VIEW",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
