part of simple_memory;


class Game {
  int score =  0;
  int highScore = 0;
  Stopwatch currentTime = new Stopwatch();
  
  int gameState;
  
  int enumStateMenu = 0;  // Menu on top of middle area of game offering game types
  int enumStatePreview = 1;  // cards revealed, player action does nothing
  int enumStatePlaying = 2;  //cards hidden, player can select
  int enumStateFinished = 3;  // Reveal all cards, show score, offer new game
  
  int previewState;
  
  int enumPreviewReady = 0;
  int enumPreviewGo = 1;
  int enumPreviewReveal = 2;
  
  
  static final double roomForHud = 50.0;
  Board board;
  
  
  static double enumEasyGame = 16.0;
  static double enumMediumGame  = 28.0;
  static double enumHardGame = 40.0;
  
  double gameType = enumEasyGame;
  
  
  Game() {
    gameState = enumStateMenu;
    board = new Board(enumMediumGame);
  }
  
  // to be run whenever player says to start a new game
  void startGame() {
    board = new Board(gameType);
    
    gameState = enumStatePreview;
    previewState = enumPreviewReady;
    var timer1 = gameLoop.addTimer((timer) => previewState = enumPreviewGo, 2.0);
    var timer2 = gameLoop.addTimer((timer) => previewReveal(), 2.75);
    var timer3 = gameLoop.addTimer((timer) => startPlaying(), 6.75);
  }
  
  void previewReveal() {
    board.revealAll();
    previewState = enumPreviewReveal;
  }
  
  void startPlaying() {
    board.hideAll();
    gameState = enumStatePlaying;
    currentTime.start();
  }
  
  void finishGame() {
    gameState = enumStateFinished;
    currentTime.stop();
  }
  
  void update(double dt) {
    bool click = gameLoop.mouse.pressed(Mouse.LEFT);
    int x = gameLoop.mouse.clampX;
    int y = gameLoop.mouse.clampY;
    
    switch (gameState) {
      case 0:  // Menu
        if (click) {
          if (x < 400 && x > 275 && 
              y < 410 && y > 360) {
            gameType = enumEasyGame;
            score = 20000;
            startGame();
          }
          
          if (x < 575 && x > 450 &&
              y < 410 && y > 360) {
            gameType = enumMediumGame;
            score = 40000;
            startGame();
          }
          
          if (x < 750 && x > 625 &&
              y < 410 && y > 360) {
            gameType = enumHardGame;
            score = 60000;
            startGame();
          }
        }
        break;
      case 1:  // Preview
          // No updates, its all draws and a concurrent timer
        break;
      case 2: // Playing
       if (click) {
         board.click(x,y);
       }
        if (board.matchesRequired == 0) {
          if (score > highScore) {
            highScore = score - currentTime.elapsed.inMilliseconds;
          }
          finishGame();  
        }
        break;
      case 3:  // Finished
        
        if (click && 
            x < 680 && x > 540 &&
            y < 90 && y > 50) {      
          score = 0;
          gameState = enumStateMenu;
        }
        break;
    }
  }
  
  void draw() {
    
    // draw background
    context.fillStyle = 'grey';
    context.fillRect(0, 0, viewportWidth, viewportHeight);
   
    board.draw();
    
    if (gameState == enumStatePreview) {
      context.font = '80px normal calibri';
      context.fillStyle = 'black';
      if (previewState == enumPreviewReady){
        context.fillText("READY?", 350, 400);
      }
      if (previewState == enumPreviewGo){
        context.fillText("GO!", 425, 400);
      }
      if (previewState == enumPreviewReveal) {
        context.font = '20px normal calibri';
        context.fillText("Revealing Cards", 425, 400);  //TODO Remove this
      }
    }
    
    // draw Hud
    context.fillStyle = 'black';
    context.font = '24px normal calibri';
    
    context.fillText("Current Score: ${score - currentTime.elapsed.inMilliseconds}", 20, 35);
    context.fillText("High Score: ${highScore}", 700, 35);
    
    context.fillText("Time: ${currentTime.elapsed.inSeconds}", 240, 35);
    
    context.font = '40px bold calibri';
    context.fillText("Flash Memory", 400, 40);
    
    
    if (gameState == enumStateMenu) {
      context.fillStyle = "rgb(100,100,100)";
      context.fillRect(256, 192, 512, 250);
      
      context.fillStyle = 'green';
      
      drawButton(275, 360, 125, 50); // Easy
      drawButton(450, 360, 125, 50); // Normal
      drawButton(625, 360, 125, 50); // Hard
      
      context.font = "22px normal calibri";
      context.fillStyle = "black";
      context.fillText("Flash Memory is a simple Memory Game with a Twist.", 266, 220);
      context.fillText("At the start you are given a brief glimpse of all the cards.", 266, 250);
      context.fillText("Use this to your advantage!", 266, 280);
      
      context.font = "26px Bold calibri";
      context.fillText("Select Difficulty: ", 266, 320);
      
      context.fillText("Easy", 315, 390);
      context.fillText("Normal", 475, 390);
      context.fillText("Hard", 665, 390);
    } 
    
    
    if (gameState == enumStateFinished) {
      context.fillStyle = 'green';
      context.strokeStyle = 'black';
      drawButton(540, 50, 140, 40);
      
      context.fillStyle = 'black';
      context.font = '24px normal calibri';
      if (score > highScore) {
        context.fillText("A new High Score!", 300, 75);
      } else {
        context.fillText("Not a new High Score", 300, 75);
      }
      context.font = '24px Bold calibri';
      context.fillText("Play Again?", 550, 75);
    }
  }
  
  void drawButton(x, y, width, height) {
    context.fillRect(x, y, width, height);
    context.beginPath();
    context.moveTo(x,y);
    context.lineTo(x + width, y);
    context.lineTo(x + width, y + height);
    context.lineTo(x, y + height);
    context.lineTo(x, y);
    context.stroke();
  }
}