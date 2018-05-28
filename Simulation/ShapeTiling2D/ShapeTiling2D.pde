abstract class Shape {
  abstract boolean intersects(Shape other);
  float size, x, y;
  int id;
  Shape(float size, float x, float y) {
    this.size=size;
    this.x=x;
    this.y=y;
    id=shapeID;
    shapeID++;
  }
  abstract void display();
}
int shapeID=0;
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
    //fill(size/2,100,100);
    //stroke(size/2,100,90);
    noFill();
    stroke(0,20);
    colorMode(RGB,255);
    //fill(0);
    //stroke(0);
    ellipse(x-size/2,y-size/2,size,size);
  }
}
class Rect extends Shape{
  Rect(float a,float b,float c){
    super(a,b,c);
  }
  void display(){
    noFill();
    stroke(0,20);
    rect(x-size/2,y-size/2,size,size);
    //ellipse(x,y,size,size);
  }
  boolean intersects(Shape other){
    return containsPoint(other.x-other.size/2,other.y-other.size/2)
        || containsPoint(other.x-other.size/2,other.y+other.size/2)
        || containsPoint(other.x+other.size/2,other.y-other.size/2)
        || containsPoint(other.x+other.size/2,other.y+other.size/2);
    //return dist(other.x,other.y,x,y)<size/2+other.size/2;
  }
  boolean containsPoint(float a,float b){
    return inRange(a,x-size/2,x+size/2)&&inRange(b,y-size/2,y+size/2);
  }
  boolean inRange(float t,float min,float max){
    return t>=min&&t<=max;
  }
}
//class Rect extends Shape{
//  boolean intersects(Shape other){
//    boolean b1=containsPoint(other.x,other.y);
//    boolean b2=containsPoint(other.x+other.size,other.y);
//    boolean b3=containsPoint(other.x,other.y+other.size);
//    boolean b4=containsPoint(other.x+other.size,other.y+other.size);
//    return b1||b2||b3||b4;
//  }
//  boolean containsPoint(float a,float b){
//    boolean b1= (a>=x);
//    boolean b2= (b>=y);
//    boolean b3= (a<=x+size);
//    boolean b4= (b<=y+size);
//    return b1 && b2 && b3 && b4;
//  }
//  Rect(Float a,float b,float c){
//    super(a,b,c);
//  }
//  void display(){
//    colorMode(HSB,100);
//    fill(size/2,100,100);
//    stroke(size/2,100,100);
//    colorMode(RGB,255);
//    if(!isGoodShape(this))fill(0,255,0);
//    //stroke(0);
//    rect(x,y,size,size);
//  }
//}
//color based on shape size

ArrayList<Shape>shapes;
float rad;
void setup() {
  size(500, 500);
  pixelDensity(2);
  shapes=new ArrayList<Shape>();
  doShapes();
}
void doShapes(){
  doShapes(50,40);
}
void doShapes(int a,int b){
  rad=a;
  shapes.clear();
  for(int i=a;i>=b;i--){
    rad=i;
    while(addShape()){
      Shape s=shapes.get(shapes.size()-1);
      println("added shape "+s.size+", "+s.x+","+s.y);
    }
    println("i="+i+", "+shapes.size());
  }
}
boolean isGoodShape(Shape s){
  for(Shape shape:shapes){
    if(shape.id==s.id)continue;
    if(s.intersects(shape))return false;
  }
  return true;
}
boolean addShape(){
  int maxIters=1000;
  Shape shape=new Rect(rad,random(width),random(height));
  int i=0;
  while(i<maxIters&&!isGoodShape(shape)){
    shape.x=random(width);
    shape.y=random(height);
    i++;
  }
  if(isGoodShape(shape)){
    shapes.add(shape);
    return true;
  }
  return false;
}
void mousePressed(){
  doShapes();
}
boolean isValid(Shape s){
  for(Shape s1:shapes)if(s.intersects(s1))return false;
  return true;
}
void draw() {
  background(255);
  //Rect r=new Rect(50f,100,100);
  //Rect r1=new Rect(50f,mouseX,mouseY);
  //if(r.intersects(r1))background(200);
  //r.display();
  //r1.display();
  //if(rad>=1)addShape();
  //while(!addShape()&&rad>6){
    //rad/=1.001;
  //}
  //if(rad>0)addShape();
  //rad-=5;
  for(Shape s:shapes){
    s.display();
  }
}