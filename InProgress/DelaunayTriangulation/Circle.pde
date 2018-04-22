
class Circle {
  float x, y, r;
  Circle(float a, float b, float c) {
    x=a;
    y=b;
    r=c;
  }
  boolean isValid(){
    int i=0;
    for(PVector p:points)if(contains(p))i++;
    return i>3;
  }
  boolean contains(PVector p) {
    return contains(p.x, p.y);
  }
  boolean contains(float a, float b) {
    return dist(a, b, x, y)<r;
    //return true;
  }
}