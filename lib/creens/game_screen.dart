import 'package:flutter/material.dart';
import 'package:master_mind/logic/game_logic.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  GameScreenState createState() => GameScreenState();
}

final GameLogic gameLogic = GameLogic(4); // 4色の組み合わせでゲームロジックを初期化
List<String> userGuess = []; // ユーザーの推測を保持するリスト
Map<String, int>? lastResult; // 最後の結果を保持する変数

final List<String> orbs = [
  'assets/images/red.png',
  'assets/images/yellow.png',
  'assets/images/green.png',
  'assets/images/blue.png',
  'assets/images/purple.png',
];

// ドラッグ可能なオーブを生成するウィジェット
Widget buildOrb(String orbPath) {
  return Draggable<String>(
    data: orbPath,
    feedback: Image.asset(orbPath, width: 100, height: 100),
    childWhenDragging: Opacity(
      opacity: 0.5,
      child: Image.asset(orbPath, width: 50, height: 50),
    ),
    child: Image.asset(orbPath, width: 50, height: 50),
  );
}

class GameScreenState extends State<GameScreen> {
  final GameLogic gameLogic = GameLogic(4); // 4色の組み合わせでゲームロジックを初期化
  List<Color> userGuess = []; // ユーザーの推測を保持するリスト
  Map<String, int>? lastResult; // 最後の結果を保持する変数
  Widget buildTarget(int index) {
    return DragTarget<String>(
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          if (userGuess.length > index) {
            userGuess[index] = data as Color;
          } else {
            userGuess.add(data as Color);
          }
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(color: Colors.black),
          ),
          child: userGuess.length > index
              ? Image.asset(userGuess[index] as String, width: 100, height: 100)
              : null,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '石の配置を当てろ！',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          //中央に配置
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // オーブの画像を表示
            Wrap(
              children: orbs.map((orb) => buildOrb(orb)).toList(),
            ),
            const SizedBox(height: 20),
            // ドラッグ＆ドロップのターゲットエリアを配置
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => buildTarget(index)),
            ),
            //その他のウィジェットを配置
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // ユーザーの推測をチェックして結果を取得
                  lastResult = gameLogic.checkGuess(userGuess);
                });
              },
              child: const Text('決定！'),
            ),
            const SizedBox(height: 150),
            if (lastResult != null) ...[
              Text('正解: ${lastResult!['hits']}'),
              Text('色だけ正解: ${lastResult!['blows']}'),
            ],
          ],
        ),
      ),
    );
  }

  // ここにユーザーの推測を設定するメソッドを追加
  // ...
}
