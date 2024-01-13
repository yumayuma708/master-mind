import 'dart:math';
import 'package:flutter/material.dart';

class GameLogic {
  // 利用可能な色のリスト
  static final List<Color> availableColors = [
    Colors.red, // 赤
    Colors.yellow, // 黄
    Colors.green, // 緑
    Colors.blue, // 青
    Colors.purple // 紫
  ];

  // 正解の色の組み合わせを保持する変数
  late List<Color> answer;

  GameLogic(int length) {
    answer = generateRandomAnswer(length);
  }

  // ランダムな正解の色の組み合わせを生成する関数
  List<Color> generateRandomAnswer(int length) {
    Random random = Random();
    List<Color> answer = [];

    for (int i = 0; i < length; i++) {
      answer.add(availableColors[random.nextInt(availableColors.length)]);
    }

    return answer;
  }

  // プレイヤーの推測をチェックする関数
  Map<String, int> checkGuess(List<Color> guess) {
    int hits = 0; // ヒット (位置も色も正しい)
    int blows = 0; // ブロー (色は正しいが位置が違う)

    List<Color> tempAnswer = List<Color>.from(answer);

    for (int i = 0; i < guess.length; i++) {
      if (guess[i] == tempAnswer[i]) {
        hits++;
        tempAnswer[i] = Colors.transparent;
      }
    }

    for (int i = 0; i < guess.length; i++) {
      if (guess[i] != Colors.transparent && tempAnswer.contains(guess[i])) {
        blows++;
        tempAnswer[tempAnswer.indexOf(guess[i])] = Colors.transparent;
      }
    }

    return {'hits': hits, 'blows': blows};
  }
}
