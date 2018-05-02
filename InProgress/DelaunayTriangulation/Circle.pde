class Circle{
  float r;
  PVector center;
  void display(color str){
    stroke(str);
    noFill();
    ellipse(center.x,center.y,r*2,r*2);
  }
  boolean contains(PVector p){
    return center.dist(p)<r;
  }
}