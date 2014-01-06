part of simple_memory;


class Game {
  int score =  0;
  int highScore = 0;
  int currentTime = 0;
  
  int gameState;
  
  int enumStateMenu = 0;  // Menu on top of middle area of game offering game types
  int enumStatePreview = 1;  // cards revealed, player action does nothing
  int enumStatePlaying = 2;  //cards hidden, player can select
  int enumStateFinished = 3;  // Reveal all cards, show score, offer new game
  
  Game() {
    gameState = enumStateMenu;
  }
  
  // to be run whenever player says to start a new game
  void startGame() {
    //initialize all the cards
    
    gameState = enumStatePreview;
  }
  
  void finishGame() {
    gameState = enumStateFinished;
    
    // pause the score timer 
  }
  
  void update(double dt) {
    bool click = gameLoop.mouse.isDown(Mouse.LEFT);
    int x = gameLoop.mouse.clampX;
    int y = gameLoop.mouse.clampY;
    
    switch (gameState) {
      case 0:  // Menu
        if (click) {
          if (x < 400 && x > 275 && 
              y < 410 && y > 360) {
            print("Easy Game");
            startGame();
          }
          
          if (x < 575 && x > 450 &&
              y < 410 && y > 360) {
            print("Normal Game");
            startGame();
          }
          
          if (x < 750 && x > 625 &&
              y < 410 && y > 360) {
            print("Hard Game");
            startGame();
          }
        }
        break;
      case 1:  // Preview
        // Announce READY?
        // Announce GO!
        // Reveal cards for a set amount of time
        // Hide cards, and start timer.  Then switch to enumStatePlaying
        
        //temp Line
        gameState = enumStatePlaying;
        break;
      case 2: // Playing
        // check for input from mouse to select cards
        
        //temp change for testing
        finishGame();
        break;
      case 3:  // Finished
        
        if (click && 
            x < 680 && x > 540 &&
            y < 90 && y > 50) {
          print("New Game");
          
          if (score > highScore) {
            highScore = score;
          }
          score = 0;
          gameState = enumStateMenu;
        }
        break;
    }
  }
  
  void draw() {
    
    // draw background
    context.fillStyle ='grey';
    context.fillRect(0, 0, viewportWidth, viewportHeight);
   
    // draw board?
    // draw cards?
    
    
    // draw Hud
    context.fillStyle = 'black';
    context.font = '24px normal calibri';
    
    context.fillText("Current Score: ${score}", 20, 35);
    context.fillText("High Score: ${highScore}", 200, 35);
    
    context.fillText("Time: ${currentTime}", 770, 35);
    
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