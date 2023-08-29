import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:priority_debug/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.setPortrait();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  static FlameGame buildMoteBeforeEnemyGame() {
    return PriorityDebugGame(moteDuration: 0.5);
  }

  static FlameGame buildMoteAfterEnemyGame() {
    return PriorityDebugGame(moteDuration: 1.5);
  }

  FlameGame? game;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Priority Debug',
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              if (game != null) //
                GameWidget(game: game!),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () => setState(() {
                        game = buildMoteBeforeEnemyGame();
                      }),
                      child: const Text('Delete Mote First'),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => setState(() {
                        game = buildMoteAfterEnemyGame();
                      }),
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
