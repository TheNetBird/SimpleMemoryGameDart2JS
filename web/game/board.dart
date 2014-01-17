part of simple_memory;

class Board {
  List<List<Card>> cards = new List<List<Card>>();
  
  final double cardsPerColumn = 4.0;
  double cardsPerRow;
  double matchesRequired;
  Card previousSelection = null;
  
  Board(double numCards) {
    matchesRequired = numCards/2;
    cardsPerRow = numCards / cardsPerColumn;   // There will always be 4 rows
    createBoard();
  }
  
  void createBoard() {
    MatchList mList = new MatchList();
    //TODO make code here so that an identifier is retrieved
    // and then used for two different cards before getting a new
    // identifier
    
    
    double totalGapW = (viewportWidth - Card.cardWidth * cardsPerRow);
    double singleGapW = totalGapW / (cardsPerRow + 1);
    
    double totalGapH = (viewportHeight - Card.cardHeight * cardsPerColumn - Game.roomForHud);
    double singleGapH = totalGapH / (cardsPerColumn + 1);
    
    Identifier previousIdentifier = null;
    Identifier newIdentifier;
    for (int i = 0; i < cardsPerRow; i++) {
      cards.add(new List<Card>());
      for (int j = 0; j < cardsPerColumn; j++) {
        if (null == previousIdentifier) {
          newIdentifier = mList.getIdentifier();
          previousIdentifier = newIdentifier;
        } else {
          newIdentifier = previousIdentifier;
          previousIdentifier = null; // its been used 2x, back to being blank
        }
        cards[i].add(new Card(newIdentifier, 
            (i + 1) * singleGapW + i * Card.cardWidth, 
            (j + 1) * singleGapH + j * Card.cardHeight + Game.roomForHud ));
        newIdentifier = null; 
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
  

  void draw() {
    for (int i = 0; i < cardsPerRow; i++) {
      for (int j = 0; j < cardsPerColumn; j++) {
        cards[i][j].draw();
      }
    }
  }
  
  void click(int x, int y) {
    for (int i = 0; i < cardsPerRow; i++) {
      for (int j = 0; j < cardsPerColumn; j++) {
        Card card =  cards[i][j];
         if (x > card.x && x < card.x + Card.cardWidth &&
             y > card.y && y < card.y + Card.cardHeight) {
           bool goodSelection = card.select();
           if (goodSelection) {
             newSelection(card);
           }
         }  
      }
    }
  }
  
  newSelection(Card card) {
    if (previousSelection == null) {
      // initial card pick
      card.revealed = true;
      previousSelection = card;
      card.selected = true;
    } else if (previousSelection.identifier == card.identifier) {
      // Successful Match
      previousSelection.selected = false;
      previousSelection.matchMade = true;
      previousSelection = null;
      card.matchMade = true;
      Game.matchesLeft--;
    } else {
      // UnSuccessful Match
      previousSelection.selected = false;
      previousSelection.revealed = false;
      previousSelection = null;
    }
  }
}