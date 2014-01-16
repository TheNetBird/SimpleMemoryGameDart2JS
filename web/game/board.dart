part of simple_memory;

class Board {
  List<List<Card>> cards = new List<List<Card>>();
  
  final double cardsPerColumn = 4.0;
  double cardsPerRow;
  double matchesRequired;
  
  Board(double numCards) {
    matchesRequired = numCards/2;
    cardsPerRow = numCards / cardsPerColumn;
    createBoard();
  }
  
  void createBoard() {
    for (int i = 0; i < cardsPerRow; i++) {
      cards.add(new List<Card>());
      for (int j = 0; j < cardsPerColumn; j++) {
        cards[i].add(new Card(i + j));
      }
    }
  }
  
  void revealAll() {
    for (int i = 0; i < cards.length; i++) {
      for (int j = 0; j < cards[i].length; j++) {
        cards[i][j].revealed = true;
      }
    }
  }
  
  void hideAll() {
    for (int i = 0; i < cards.length; i++) {
      for (int j = 0; j < cards[i].length; j++) {
        cards[i][j].revealed = false;
      }
    }
  }
  
  // There will always be 4 rows
  void draw() {
    double totalGapW = (viewportWidth - Card.cardWidth * cardsPerRow);
    double singleGapW = totalGapW / (cardsPerRow + 1);
    
    double totalGapH = (viewportHeight - Card.cardHeight * cardsPerColumn - Game.roomForHud);
    double singleGapH = totalGapH / (cardsPerColumn + 1);
    

    for (int i = 0; i < cards.length; i++) {
      for (int j = 0; j < cards[i].length; j++) {
        cards[i][j].draw(
            (i + 1) * singleGapW + i * Card.cardWidth, 
            (j + 1) * singleGapH + j * Card.cardHeight + Game.roomForHud );
      }
    }
  }
  
}