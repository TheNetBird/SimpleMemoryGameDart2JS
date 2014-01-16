part of simple_memory;


class Card {
  // Hold whether or not it is currently revealed
  // Holds directions to draw itself
  bool revealed = false;
  static final double cardWidth = 80.0;
  static final double cardHeight = 100.0;
  
  int identifier;
  
  Card(int identifier){
    this.identifier = identifier;
  }
  
  void draw(double x, double y) {
    if (revealed) {
      context.fillStyle = 'white';
      context.fillRect(x, y, cardWidth, cardHeight);
      drawIdentifier(x,y);
    } else {
      context.fillStyle = 'brown';
      context.fillRect(x, y, cardWidth, cardHeight);
    }
  }
  
  void drawIdentifier(double x, double y){
    context.fillStyle = 'black';
    context.font = '32px normal calibri';
    context.fillText(identifier.toString(), x + cardWidth/2, y + cardHeight/2);
  }
}