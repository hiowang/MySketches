class Player extends Entity{
  
  Player(){
    super(width/2,height/2,color(255,200,200),color(255,200,200));
  }
  
  void update(){
    respondToKeys();
  }
  
}