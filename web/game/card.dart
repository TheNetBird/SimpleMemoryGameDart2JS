part of simple_memory;

/*
 * Contains card state
 */
class Card {
  bool revealed = false;
  static final double cardWidth = 80.0;
  static final double cardHeight = 100.0;
  
  double x = 0.0;
  double y = 0.0;
  
  Identifier identifier;
  bool matchMade = false;
  bool selected = false;
  
  Card(Identifier identifier){
    this.identifier = identifier;
  }
  
  void draw() {
    if (matchMade) {
      context.fillStyle = 'grey';
      context.fillRect(x, y, cardWidth, cardHeight);
      drawIdentifier(x,y);
    } else if (revealed) {
      context.fillStyle = 'white';
      context.fillRect(x, y, cardWidth, cardHeight);
      drawIdentifier(x,y);
    } else {
      context.fillStyle = 'brown';
      context.fillRect(x, y, cardWidth, cardHeight);
    }
    if(selected) {
      context.strokeStyle = 'blue';
      context.beginPath();
      context.moveTo(x, y);
      context.lineTo(x+ Card.cardWidth, y);
      context.lineTo(x + Card.cardWidth, y + Card.cardHeight);
      context.lineTo(x, y + Card.cardHeight);
      context.stroke();
    }
  }
  
  /*
   * Returns true if the card is selectable.
   */
  bool select() {
    if (!matchMade && !selected) {
      return true;
    } else {
      return false;
    }
  }
  
  void drawIdentifier(double x, double y){
    context.fillStyle = 'black';
    context.font = '32px normal calibri';
    context.fillText(identifier.number.toString(), x + cardWidth/2, y + cardHeight/2);
  }
  
  void tempReveal() {
    this.revealed = true;
    gameLoop.addTimer((timedHide) => hide(), 0.75);
  }
  
  void hide() {
    this.revealed = false;
  }
}