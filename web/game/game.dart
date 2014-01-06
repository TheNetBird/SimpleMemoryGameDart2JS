part of simple_memory;


class Game {
  int score =  0;
  int highScore = 0;
  int currentTime = 0;
  
  
  // Run once, when application starts
  void initializeGame() {
    // maybe give player options as to how many cards there will be 
  }
  
  // to be run whenever player says to start a new game
  void startGame() {
    //initialize all the cards
    
    
    // reveal cards to player for set amount of time
    // flip cards over
    // start timer
  }
  
  void finishGame() {
    // do high Score check, should it be updated?
    // move into state where player is asked do they want to play again?
  }
  
  void update(double dt) {
    // check for input from mouse
    // if player has clicked on a card, reveal that card
  }
  
  void draw() {
    // draw background
    context.fillStyle ='grey';
    context.fillRect(0, 0, viewportWidth, viewportHeight);
   
    // draw board
    
    
    
    // draw Hud
    context.fillStyle = 'black';
    context.font = '20px normal calibri';
    context.fillText("Current Score: ${score}", 20, 30);
    context.fillText("High Score: ${highScore}", 200, 30);
    
    context.fillText("Time: ${currentTime}", 770, 30);
    
    
    context.font = '40px bold calibri';
    context.fillText("Flash Memory", 400, 40);
    
    
    // draw cards
    
  }
}