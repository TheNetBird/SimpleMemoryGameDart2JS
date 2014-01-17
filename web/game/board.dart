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
    
    List<Card> identifiedCards = new List<Card>();
    
    Identifier previousIdentifier = null;
    Identifier newIdentifier;
    for (int i = 0; i < cardsPerRow * cardsPerColumn; i++) {

      if (null == previousIdentifier) {
        newIdentifier = mList.getIdentifier();
        previousIdentifier = newIdentifier;
      } else {
        newIdentifier = previousIdentifier;
        previousIdentifier = null; // its been used 2x, back to being blank
      }
      identifiedCards.add(new Card(newIdentifier, 0.0, 0.0));
      //cards[i].add(new Card(newIdentifier, 0.0, 0.0));
      newIdentifier = null; 
    }
    addIdentifiedCardsToBoard(identifiedCards);
    assignLocations();
  }
  
  addIdentifiedCardsToBoard(List<Card> identifiedCards) {
    var rng = new Random();
    List<int> availableSpotsList = new List<int>();
    
    for (int i = 0; i < cardsPerRow * cardsPerColumn; i++) {
      availableSpotsList.add(i+1);
    }
    // Create the board of the right size
    cards = new List<List<Card>>(cardsPerColumn.toInt());
    for (int i = 0; i < cards.length; i++){
      cards[i] = new List<Card>(cardsPerRow.toInt());
    }
    
    
    for (int i = 0; i < identifiedCards.length; i++) {
      int pickedNumber = rng.nextInt(availableSpotsList.length);
      int cardLocation = availableSpotsList[pickedNumber];
      availableSpotsList.removeAt(pickedNumber);
      
      cardLocation--;
      int cardCol = cardLocation % cardsPerRow.toInt();
      int cardRow = (cardLocation / cardsPerRow.toInt()).floor();
      cards[cardRow][cardCol] = identifiedCards[i];
      
    }
  }
  
  assignLocations() {
    double totalGapW = (viewportWidth - Card.cardWidth * cardsPerRow);
    double singleGapW = totalGapW / (cardsPerRow + 1);
    
    double totalGapH = (viewportHeight - Card.cardHeight * cardsPerColumn - Game.roomForHud);
    double singleGapH = totalGapH / (cardsPerColumn + 1);
    
    for (int i = 0; i < cardsPerColumn; i++) {
      for (int j = 0; j < cardsPerRow; j++) {
        cards[i][j].x = (j + 1) * singleGapW + j * Card.cardWidth;
        cards[i][j].y = (i + 1) * singleGapH + i * Card.cardHeight + Game.roomForHud ;
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
    for (int i = 0; i < cardsPerColumn; i++) {
      for (int j = 0; j < cardsPerRow; j++) {
        cards[i][j].draw();
      }
    }
  }
  
  void click(int x, int y) {
    for (int i = 0; i < cardsPerColumn; i++) {
      for (int j = 0; j < cardsPerRow; j++) {
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