library simple_memory;

import 'package:game_loop/game_loop_html.dart';
import 'dart:html';
import 'dart:core';

part 'game/game.dart';
part 'game/board.dart';
part 'game/card.dart';
part 'game/identifer.dart';

CanvasElement canvas;
CanvasRenderingContext2D context;

int viewportWidth = 1024;
int viewportHeight = 768;

GameLoopHtml gameLoop = new GameLoopHtml(canvas);
int _lastFrame;

void main() {
  buildCanvas();
  
  Game game = new Game();
  gameLoop.pointerLock.lockOnClick = false;
  
  gameLoop.onUpdate = ((gameLoop) {
    if (_lastFrame == gameLoop.frame) {
      return;
    } else {
      _lastFrame = gameLoop.frame;
    }
    game.update(gameLoop.dt);
  });
  gameLoop.onRender = ((gameLoop) {
    game.draw();
  });
  gameLoop.start();
}

void buildCanvas() {
  canvas = query('canvas');
  canvas.width = viewportWidth;
  canvas.height = viewportHeight;
  context = canvas.getContext('2d');
}


