import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:priority_debug/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.setPortrait();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final game = PriorityDebugGame();

    void playMoteBeforeEnemy() {
      game.play(moteDuration: 0.5);
    }

    void playMoteAfterEnemy() {
      game.play(moteDuration: 1.5);
    }

    return MaterialApp(
      title: 'Priority Debug',
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              GameWidget(game: game),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: playMoteBeforeEnemy,
                      child: const Text('Delete Mote First'),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: playMoteAfterEnemy,
                      child: const Text('Leave Corpse First'),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
