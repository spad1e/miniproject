import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  String name;
  MyPlayer({required this.name});

  @override
  Widget build(BuildContext context) {
    if (name == 'redGhost') {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset('images/red_ghost.png'),
      );
    } else if (name == 'blueGhost') {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset('images/blue_ghost.png'),
      );
    } else if (name == 'portal') {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset('images/portal.png'),
      );
    } else if (name == 'player') {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset('images/pacman.png'),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset('images/pacman.png'),
      );
    }
  }
}
