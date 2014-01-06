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
    gameState = enumStateFinished;
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
    switch (gameState) {
      case 0:  // Menu
        
        // look for input selecting number of cards
        break;
      case 1:  // Preview
        // Announce READY?
        // Announce GO!
        // Reveal cards for a set amount of time
        // Hide cards, and start timer.  Then switch to enumStatePlaying
        break;
      case 2: // Playing
        // check for input from mouse to select cards
       
        break;
      case 3:  // Finished
        // Show players Time, ask them if they'd like to play again?
        // If they got a new high score, highlight this
        // button is between 540-680 and 50 - 90
        break;
    }
  }
  
  void draw() {
    
    // draw background
    context.fillStyle ='grey';
    context.fillRect(0, 0, viewportWidth, viewportHeight);
   
    // draw board
    
    
    
    // draw Hud
    context.fillStyle = 'black';
    context.font = '24px normal calibri';
    
    context.fillText("Current Score: ${score}", 20, 35);
    context.fillText("High Score: ${highScore}", 200, 35);
    
    context.fillText("Time: ${currentTime}", 770, 35);
    
    context.font = '40px bold calibri';
    context.fillText("Flash Memory", 400, 40);
    
    
    // draw cards
    
    
    if (gameState == enumStateMenu) {
      // Display Menu overtop the board
      // Menu includes explanation of the game
      // menu includes a couple options for difficulty
    } 
    
    // Draw Button
    context.fillStyle = 'green';
    context.fillRect(540, 50, 140, 40);
    context.strokeStyle = 'black';
    context.beginPath();
    context.moveTo(540,50);
    context.lineTo(680, 50);
    context.lineTo(680, 90);
    context.lineTo(540, 90);
    context.lineTo(540, 50);
    context.stroke();
    
    context.fillStyle = 'black';
    if (gameState == enumStateFinished) {
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
}