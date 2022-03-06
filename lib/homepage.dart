import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'pixel.dart';
import 'path.dart';
import 'player.dart';
import 'scoreboard.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.name});
  final name;
  @override
  State<HomePage> createState() => _HomePageState(name: name);
}

class _HomePageState extends State<HomePage> {
  _HomePageState({required this.name});
  final name;
  static int rows = 11;
  int squares = rows * 13;
  int player = 100;
  int gametick = 150;

  List<int> barriers = [
    0,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    10,
    11,
    15,
    21,
    22,
    24,
    28,
    29,
    30,
    32,
    33,
    37,
    39,
    43,
    44,
    46,
    47,
    48,
    50,
    51,
    52,
    54,
    66,
    67,
    69,
    70,
    71,
    72,
    74,
    76,
    85,
    88,
    90,
    91,
    93,
    94,
    96,
    98,
    99,
    109,
    110,
    111,
    112,
    113,
    115,
    116,
    117,
    118,
    120,
    121,
    129,
    131,
    132,
    134,
    135,
    136,
    137,
    138,
    139,
    140,
    142,
  ];
  List<int> redGhostPath = [
    12,
    13,
    14,
    25,
    26,
    27,
    38,
    49,
    60,
    59,
    58,
    57,
    56,
    45,
    34,
    23
  ];
  List<int> blueGhostPath = [
    125,
    126,
    127,
    41,
    42,
    53,
    64,
    75,
    86,
    97,
    108,
    107,
    106,
    105,
    104,
    103,
    114
  ];

  int portal1 = 40;
  int portal2 = 128;
  int redGhost = 0;
  int blueGhost = 0;
  bool preGame = true;
  bool endGame = false;
  bool mouthClosed = false;
  List<int> food = [];
  String direction = "right";
  int score = 0;

  void startGame() {
    getFood();
    preGame = false;
    score = 0;
    Timer.periodic(Duration(milliseconds: 2 * gametick), (timer) {
      if (endGame) {
        timer.cancel();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultPage(score: score, name: name)));
      }
      setState(() {
        if (blueGhost + 1 < blueGhostPath.length) {
          blueGhost++;
        } else {
          blueGhost = 0;
        }
        if (redGhost + 1 < redGhostPath.length) {
          redGhost++;
        } else {
          redGhost = 0;
        }
      });
    });
    Timer.periodic(Duration(milliseconds: gametick), (timer) {
      setState(() {
        mouthClosed = !mouthClosed;
      });
      if (player == redGhostPath[redGhost] ||
          player == blueGhostPath[blueGhost] ||
          food.isEmpty) {
        endGame = true;
      }
      if (endGame) {
        player = -1;
        timer.cancel();
      } else {
        if (food.contains(player)) {
          food.remove(player);
          score++;
        }
        if (player == portal1) {
          player = portal2;
        } else if (player == portal2) {
          player = portal1;
        }
        switch (direction) {
          case "left":
            if ((player - 1) ~/ rows != player ~/ rows) {
              setState(() {
                player--;
                player += rows;
              });
            } else if (!barriers.contains(player - 1)) {
              setState(() {
                player--;
              });
            }
            break;
          case "right":
            if ((player + 1) ~/ rows != player ~/ rows) {
              setState(() {
                player++;
                player -= rows;
              });
            } else if (!barriers.contains(player + 1)) {
              setState(() {
                player++;
              });
            }
            break;
          case "up":
            if (player - rows < 0) {
              setState(() {
                player -= rows;
                player += squares;
              });
            } else if (!barriers.contains(player - rows)) {
              setState(() {
                player -= rows;
              });
            }
            break;
          case "down":
            if (player + rows >= squares) {
              setState(() {
                player += rows;
                player -= squares;
              });
            } else if (!barriers.contains(player + rows)) {
              setState(() {
                player += rows;
              });
            }
            break;
        }
      }
    });
  }

  void getFood() {
    for (int i = 0; i < squares; ++i) {
      if (!barriers.contains(i)) food.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (!preGame) {
                    if (details.delta.dy > 0 &&
                        !barriers.contains(player + rows)) {
                      direction = "down";
                    } else if (details.delta.dy < 0 &&
                        !barriers.contains(player - rows)) {
                      direction = "up";
                    }
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (!preGame) {
                    if (details.delta.dx > 0 &&
                        !barriers.contains(player + 1)) {
                      direction = "right";
                    } else if (details.delta.dx < 0 &&
                        !barriers.contains(player - 1)) {
                      direction = "left";
                    }
                  }
                },
                child: Container(
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: squares,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: rows),
                      itemBuilder: (BuildContext context, int index) {
                        if (player == index) {
                          if (mouthClosed) {
                            return Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 254, 203, 0),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          } else {
                            switch (direction) {
                              case "left":
                                return Transform.rotate(
                                  angle: pi,
                                  child: MyPlayer(name: 'player'),
                                );
                              case "right":
                                return Transform.rotate(
                                  angle: 0,
                                  child: MyPlayer(name: 'player'),
                                );
                              case "up":
                                return Transform.rotate(
                                  angle: -pi / 2,
                                  child: MyPlayer(name: 'player'),
                                );
                              case "down":
                                return Transform.rotate(
                                  angle: pi / 2,
                                  child: MyPlayer(name: 'player'),
                                );
                            }
                            return MyPlayer(name: 'player');
                          }
                        } else if (barriers.contains(index)) {
                          return MyPixel(
                            innerColor: Colors.blue.shade800,
                            outerColor: Colors.blue.shade900,
                            // child: Text(index.toString()),
                          );
                        } else if (index == portal1 || index == portal2) {
                          return MyPlayer(name: 'portal');
                        } else if (index == redGhostPath[redGhost]) {
                          return MyPlayer(name: 'redGhost');
                        } else if (index == blueGhostPath[blueGhost]) {
                          return MyPlayer(name: 'blueGhost');
                        } else if (food.contains(index) || preGame) {
                          return MyPath(
                            innerColor: Colors.yellow,
                            outerColor: Colors.black,
                            // child: Text(index.toString()),
                          );
                        } else {
                          return MyPath(
                            innerColor: Colors.black,
                            outerColor: Colors.black,
                            // child: Text(index.toString()),
                          );
                        }
                      }),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Score: " + score.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    GestureDetector(
                      onTap: startGame,
                      child: Text(
                        "P L A Y",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
