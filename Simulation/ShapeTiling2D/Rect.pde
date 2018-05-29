
class Rect extends Shape {
  Rect(float a, float b, float c) {
    super(a, b, c);
  }
  boolean allOnScreen(){
    return inRange(x-size/2,0,width)&&inRange(x+size/2,0,width)&&inRange(y-size/2,0,height)&&inRange(y+size/2,0,height);
  }
  void display() {
    //noFill();
    //stroke(0,20);

    colorMode(HSB, 100);
    fill(map(size, startRad, endRad, 10, 100), 40, 100);
    //stroke(size/2,100,90);
    colorMode(RGB, 255);
    //noFill();
    stroke(0, 20);
    rect(x-size/2, y-size/2, size, size);
    //ellipse(x,y,size,size);
  }
  boolean intersects(Shape other) {
    //return other.containsPoint(x+size/2, y+size/2)
      //||other.containsPoint(x+size/2, y-size/2)
      //||other.containsPoint(x-size/2, y+size/2)
      //||other.containsPoint(x-size/2, y-size/2);
      if(other instanceof Rect)return containsPoint(other.x-other.size/2,other.y+other.size/2)
      ||containsPoint(other.x-other.size/2,other.y-other.size/2)
      ||containsPoint(other.x+other.size/2,other.y+other.size/2)
      ||containsPoint(other.x+other.size/2,other.y-other.size/2);
      return other.containsPoint(x+size/2, y+size/2);
      //||other.containsPoint(x+size/2, y-size/2)
      //||other.containsPoint(x-size/2, y+size/2)
      //||other.containsPoint(x-size/2, y-size/2);
  }
  boolean containsPoint(float a, float b) {
    return inRange(a, x-size/2, x+size/2)&&inRange(b, y-size/2, y+size/2);
  }
}