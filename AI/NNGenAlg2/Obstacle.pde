class Obstacle{
  float x,y,r;
  Obstacle(float _1,float _2,float _3){
    x=_1;
    y=_2;
    r=_3;
  }
  void display(){
    stroke(0);
    fill(255/2);
    ellipse(x,y,r*2,r*2);
  }
}