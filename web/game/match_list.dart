part of simple_memory;

class MatchList{
  
  List<Identifier> availableIList = new List<Identifier>();
  var rng = new Random();
  
  MatchList() {
    createIdentifiers();
  }
  
  Identifier getIdentifier() {
    int next = rng.nextInt(availableIList.length);
    Identifier answer = availableIList[next];
    availableIList.removeAt(next);
    return answer;
  }
  
 // resestList() {
  //  availableIList = new List<Identifier>();
 //   createIdentifiers();
 // }
  
  createIdentifiers() {
    availableIList.add(new Identifier(1));
    availableIList.add(new Identifier(2));
    availableIList.add(new Identifier(3));
    availableIList.add(new Identifier(4));
    availableIList.add(new Identifier(5));
    availableIList.add(new Identifier(6));
    availableIList.add(new Identifier(7));
    availableIList.add(new Identifier(8));
    availableIList.add(new Identifier(9));
    availableIList.add(new Identifier(10));
    availableIList.add(new Identifier(11));
    availableIList.add(new Identifier(12));
    availableIList.add(new Identifier(13));
    availableIList.add(new Identifier(14));
    availableIList.add(new Identifier(15));
    availableIList.add(new Identifier(16));
    availableIList.add(new Identifier(17));
    availableIList.add(new Identifier(18));
    availableIList.add(new Identifier(19));
    availableIList.add(new Identifier(20));
  }
}