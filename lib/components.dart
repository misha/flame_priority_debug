import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:priority_debug/game.dart';

enum Priority {
  corpse,
  enemy,
  player,
  mote,
}

class Player extends CircleComponent {
  Player()
      : super(
          radius: 10,
          anchor: Anchor.bottomCenter,
          paint: Paint() //
            ..color = Colors.green,
          priority: Priority.player.index,
        );
}

class Enemy extends CircleComponent with HasGameRef<PriorityDebugGame> {
  Enemy()
      : super(
          radius: 10,
          anchor: Anchor.bottomCenter,
          paint: Paint() //
            ..color = Colors.red,
          priority: Priority.enemy.index,
        );

  void kill() {
    Corpse() //
      ..position = position
      ..addToParent(game.world);

    removeFromParent();
  }
}

class Mote extends CircleComponent {
  Mote({
    required this.duration,
  }) : super(
          radius: 2,
          anchor: Anchor.center,
          paint: Paint() //
            ..color = Colors.orange,
          priority: Priority.mote.index,
        );

  final double duration;
  double elapsed = 0;

  @override
  void update(double dt) {
    elapsed += dt;

    if (elapsed >= duration) {
      removeFromParent();
    }
  }
}

class Corpse extends CircleComponent {
  Corpse()
      : super(
          radius: 10,
          anchor: Anchor.bottomCenter,
          paint: Paint() //
            ..color = Colors.purple,
          priority: Priority.corpse.index,
        );
}
