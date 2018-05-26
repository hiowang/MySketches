abstract class Shape {
  abstract boolean intersects(Shape other);
  float size, x, y;
  Shape(float size, float x, float y) {
    this.size=size;
    this.x=x;
    this.y=y;
  }
  abstract void display();
}
class Circle extends Shape{
  boolean intersects(Shape other){
    return dist(other.x,other.y,x,y)<size/2+other.size/2;
    //return false;
  }
  Circle(float a,float b,float c){
    super(a,b,c);
  }
  void display(){
    //fill(size);
    colorMode(HSB,100);
    fill(size/2,100,100);
    colorMode(RGB,255);
    //fill(0);
    stroke(0);
    ellipse(x,y,size,size);
  }
}
//color based on shape size

ArrayList<Shape>shapes;
float rad;
void setup() {
  size(500, 500);
  shapes=new ArrayList<Shape>();
  //rad=500;
  for(int i=200;i>=2;i--){
    rad=i;
    while(addShape()){
      Shape s=shapes.get(shapes.size()-1);
      println("added shape "+s.size+", "+s.x+","+s.y);
    }
    println("i="+i+", "+shapes.size());
  }
}
boolean addShape(){
  int maxIters=500;
  Shape shape=new Circle(rad,random(width),random(height));
  int i=0;
  boolean valid=true;
  for(Shape s:shapes)if(shape.intersects(s))valid=false;
  while(i<maxIters&&!valid){
    shape.x=random(width);
    shape.y=random(height);
    valid=true;
    for(Shape s:shapes)if(shape.intersects(s))valid=false;
    i++;
  }
  //println(i);
  if(i!=maxIters){
    shapes.add(shape);
    return true;
  }
  return false;
}
boolean isValid(Shape s){
  for(Shape s1:shapes)if(s.intersects(s1))return false;
  return true;
}
void draw() {
  background(255);
  for(Shape s:shapes){
    s.display();
  }
}