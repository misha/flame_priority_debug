import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:priority_debug/components.dart';

class PriorityDebugGame extends FlameGame {
  World world = DebugWorld();

  void play({
    required double moteDuration,
  }) {
    if (world.isMounted) {
      world.removeFromParent();
    }

    world = DebugWorld();
    final player = Player();
    world.add(player);

    final camera = CameraComponent(world: world);
    camera.viewfinder.anchor = Anchor.center;
    camera.viewfinder.zoom = 5;
    camera.follow(player);

    final position = player.position.clone() //
      ..x += 10;

    final enemy = Enemy() //
      ..position = position
      ..addToParent(world);

    Mote(duration: moteDuration) //
      ..position = Vector2(5, -25)
      ..addToParent(world);

    Future.delayed(const Duration(seconds: 1), () {
      try {
        enemy.kill();
      } on AssertionError catch (_) {
        // If you removed the world while waiting,
        // this throws with `game == null`. Ignore it.
      }
    });

    addAll([camera, world]);
  }
}

class DebugWorld extends World {
  @override
  void onChildrenChanged(Component child, ChildrenChangeType type) {
    // ignore: avoid_print
    print(children);
  }
}
