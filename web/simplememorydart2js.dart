import 'package:game_loop/game_loop_html.dart';
import 'dart:html';

CanvasElement canvas;
CanvasRenderingContext2D context;

int viewportWidth = 1024;
int viewportHeight = 768;

GameLoopHtml gameLoop = new GameLoopHtml(canvas);

void main() {
  buildCanvas();
  
  gameLoop.onUpdate = ((gameLoop) {
    //update logic here
  });
  gameLoop.onRender = ((gameLoop) {
    //draw Logic here
  });
  gameLoop.start();
}

void buildCanvas() {
  canvas = query('canvas');
  canvas.width = viewportWidth;
  canvas.height = viewportHeight;
  context = canvas.getContext('2d');
}


