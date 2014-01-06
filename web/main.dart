library simple_memory;

import 'package:game_loop/game_loop_html.dart';
import 'dart:html';

part 'game/game.dart';

CanvasElement canvas;
CanvasRenderingContext2D context;

int viewportWidth = 1024;
int viewportHeight = 768;

GameLoopHtml gameLoop = new GameLoopHtml(canvas);

void main() {
  buildCanvas();
  
  Game game = new Game();
  
  gameLoop.onUpdate = ((gameLoop) {
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


