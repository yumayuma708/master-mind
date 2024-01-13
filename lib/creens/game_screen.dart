import 'package:flutter/material.dart';
import 'package:master_mind/logic/game_logic.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  final GameLogic gameLogic = GameLogic(4); // 4色の組み合わせでゲームロジックを初期化
  List<Color> userGuess = []; // ユーザーの推測を保持するリスト
  Map<String, int>? lastResult; // 最後の結果を保持する変数

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mastermind Game'),
      ),
      body: Column(
        children: [
          // ここにユーザーの入力ウィジェットを追加
          // ...

          ElevatedButton(
            onPressed: () {
              setState(() {
                // ユーザーの推測をチェックして結果を取得
                lastResult = gameLogic.checkGuess(userGuess);
              });
            },
            child: const Text('判定'),
          ),
          if (lastResult != null) ...[
            Text('ヒット: ${lastResult!['hits']}'),
            Text('ブロー: ${lastResult!['blows']}'),
          ],
        ],
      ),
    );
  }

  // ここにユーザーの推測を設定するメソッドを追加
  // ...
}
