import java.util.Collections;

ArrayList<Shape>shapes;
float rad;
int startRad=200;
int endRad=2;
ShapeType type=ShapeType.CIRC;
enum ShapeType {
  RECT, CIRC;
}
float clamp(float val, float min, float max) {
  if (val<min)return min;
  if (val>max)return max;
  return val;
}
boolean inRange(float t, float min, float max) {
  return t>=min && t<=max;
}
void setup() {
  //size(3000,3000);
  //fullScreen();
  size(500, 500);
  //size(200,200);
  //size(1000, 1000);
  pixelDensity(2);
  shapes=new ArrayList<Shape>();
  rad=startRad;
  background(255);
  //while(rad>=endRad){
    //while(!addShape())rad--;
  //}
  //for(Shape s:shapes){
    //s.display();
  //}
  //save("results/"+startRad+"-"+endRad+".png");
  //rad=startRad;
  //shapes.add(new Circle(rad,width/2,height/2));
}
boolean isGoodShape(Shape s) {
  for (Shape shape : shapes) {
    if (shape.id==s.id)continue;
    if (shape.intersects(s))return false;
  }
  return s.allOnScreen();
}
boolean addShape() {
  //int maxIters=50000;
  //Shape shape=new Circle(rad, random(width), random(height));
  ////Shape shape=new Rect(rad, random(width), random(height));
  //int i=0;
  //while (i<maxIters&&!isGoodShape(shape)) {
  //  shape.x=random(width);
  //  shape.y=random(height);
  //  i++;
  //}
  //if (isGoodShape(shape)) {
  //  shapes.add(shape);
  //  return true;
  //}
  //return false;
  ArrayList<Shape>valids=new ArrayList<Shape>();
  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      Shape s1=new Rect(rad, i, j);
      if (isGoodShape(s1))valids.add(s1);
      Shape s2=new Circle(rad+3, i, j);
      if (isGoodShape(s2))valids.add(s2);
    }
  }
  if (valids.size()==0) {
    return false;
  } else {
    Collections.shuffle(valids);
    int lowestInd=0;
    //float lowestScore=10000;
    //for(int i=0;i<valids.size();i++){
    //float score=0;
    //Shape shape=valids.get(i);
    //for(Shape s:shapes)score+=dist(s.x,s.y,shape.x,shape.y);
    //if(score<lowestScore||random(100)<20){
    //lowestScore=score;
    //lowestInd=i;
    //}
    //}
    //Shape s=valids.get(0);//maybe sort by the position with the smallest sum of (distance to all other shapes)
    Shape s=valids.get(lowestInd);
    shapes.add(s);
    return true;
  }
}
void mousePressed() {
  //doShapes();
  rad=startRad;
  shapes.clear();
}
boolean paused=false;
void keyPressed() {
  if (key=='s') {
    selectOutput("Select a file to save to: ", "outFileSelected");
  }
  if (key==' ') {
    paused=!paused;
  }
}
void outFileSelected(File f) {
  if (f==null)return;
  save(f.getAbsolutePath());
}
boolean isValid(Shape s) {
  for (Shape s1 : shapes)if (s.intersects(s1))return false;
  return true;
}
void draw() {
  background(255);
  //Rect r=new Rect(50, width/2, height/2);
  //Circle c=new Circle(50, mouseX, mouseY);
  //if (c.intersects(r))background(0);
  //r.display();
  //c.display();
  for (Shape s : shapes) {
    s.display();
  }
  if (!paused) {
    if (rad>=endRad) {
      for (int i=0; i<1; i++)while (!addShape())rad--;
    }
    //for (Shape s1 : shapes) {
    //for (Shape s2 : shapes) {
    //stroke(0);
    //if (new Circle(s1.size+5,s1.x,s1.y).intersects(new Circle(s2.size+5,s2.x,s2.y))&&s1.id!=s2.id)line(s1.x, s1.y, s2.x, s2.y);
    //}
    //}
  }
}