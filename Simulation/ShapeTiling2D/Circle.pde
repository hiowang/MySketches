class Circle extends Shape {
  boolean intersects(Shape other) {
    if(other instanceof Circle)return dist(other.x, other.y, x, y)<size/2+other.size/2;
    return other.intersects(this);
    //return false;
  }
  boolean allOnScreen(){
    return inRange(x-size/2,0,width)&&inRange(x+size/2,0,width)&&inRange(y-size/2,0,height)&&inRange(y+size/2,0,height);
  }
  boolean containsPoint(float a, float b) {
    return dist(x,y,a,b)<size/2;
  }
  Circle(float a, float b, float c) {
    super(a, b, c);
  }
  void display() {
    //fill(size);
    colorMode(HSB, 100);
    fill(map(size, startRad, endRad, 10, 100), 40, 100);
    //noFill();
    colorMode(RGB, 255);
    stroke(0, 20);
    ellipse(x, y, size, size);
  }
}