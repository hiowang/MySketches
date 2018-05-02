ArrayList<PVector>points;
ArrayList<Triangle>tris;

void setup() {
  size(500, 500);
  pixelDensity(2);
  points=new ArrayList<PVector>();
  tris=new ArrayList<Triangle>();
}
void keyPressed(){
  int n=0;
  if(key=='1')n=1;
  if(key=='2')n=2;
  if(key=='3')n=5;
  if(key=='4')n=10;
  for(int i=0;i<n;i++){
    points.add(new PVector(random(width),random(height)));
    changedPoints=true;
  }
}
boolean changedPoints=false;
void mousePressed() {
  points.add(new PVector(mouseX, mouseY));
  changedPoints=true;
}
void draw() {
  background(255);
  for (PVector p : points) {
    displayPoint(p,0);
  }
  if(changedPoints){
    doTriangulation();
    changedPoints=false;
  }
  for (Triangle t : tris) {
    color col1=t.isGood()?color(0, 100):color(255, 0, 0, 100);
    color col2=t.isGood()?color(0, 25):color(255, 0, 0, 25);
    col1=color(0);
    col2=color(0, 10);
    if (!t.isGood()) {
      col1=color(255, 0, 0);
      col2=color(0, 60);
      displayPoint(t.p1,color(255,0,0));
      displayPoint(t.p2,color(255,0,0));
      displayPoint(t.p3,color(255,0,0));
    }
    t.display(col1);
    //t.circum().display(col2);
    //for(Triangle t1:tris){
    //  if(isAdjacent(t,t1)){
    //    PVector p1=t.center();
    //    PVector p2=t1.center();
    //    stroke(0,0,255,20);
    //    line(p1.x,p1.y,p2.x,p2.y);
    //  }
    //}
  }
}
void displayPoint(PVector p, color col) {
  fill(col);
  noStroke();
  ellipse(p.x, p.y, 15, 15);
}